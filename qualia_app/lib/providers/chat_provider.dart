import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import 'partner_agent_provider.dart';
import 'visual_director_agent_provider.dart';
import 'strategist_agent_provider.dart';
import 'comfyui_provider.dart';
import 'storage_provider.dart';
import 'session_provider.dart';
import '../services/agents/partner_agent.dart';
import '../services/agents/strategist_agent.dart';
import '../services/agents/input_interpreter_agent.dart';
import '../services/comfyui_service.dart';
import 'input_interpreter_provider.dart';

part 'chat_provider.g.dart';

enum ChatProcessingStage {
  idle,
  partnerThinking,
  visualDirectorWorking,
  imageGenerating,
  strategistPlanning,
  completed,
}

class ChatState {
  final String sessionId;
  final List<dynamic> messages; // TODO: Define unified message model for UI
  final bool isProcessing;
  final ChatProcessingStage processingStage;
  final List<StrategyChoice>? currentChoices;
  final PartnerProfile? partner;
  final UserProfile? user;
  final WorldState? worldState;
  final String? lastImageUrl;
  final String? error;

  ChatState({
    required this.sessionId,
    this.messages = const [],
    this.isProcessing = false,
    this.processingStage = ChatProcessingStage.idle,
    this.currentChoices,
    this.partner,
    this.user,
    this.worldState,
    this.lastImageUrl,
    this.error,
  });

  ChatState copyWith({
    String? sessionId,
    List<dynamic>? messages,
    bool? isProcessing,
    ChatProcessingStage? processingStage,
    List<StrategyChoice>? currentChoices,
    PartnerProfile? partner,
    UserProfile? user,
    WorldState? worldState,
    String? lastImageUrl,
    String? error,
  }) {
    return ChatState(
      sessionId: sessionId ?? this.sessionId,
      messages: messages ?? this.messages,
      isProcessing: isProcessing ?? this.isProcessing,
      processingStage: processingStage ?? this.processingStage,
      currentChoices: currentChoices ?? this.currentChoices,
      partner: partner ?? this.partner,
      user: user ?? this.user,
      worldState: worldState ?? this.worldState,
      lastImageUrl: lastImageUrl ?? this.lastImageUrl,
      error: error ?? this.error,
    );
  }
}

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build(String sessionId) {
    // Listen for session updates (e.g. storage init complete, or new messages)
    ref.listen(currentSessionProvider(sessionId), (previous, next) {
      if (next != null) {
        // Update local state if session updates (e.g. from background or other views)
        // Check for loading persistent choices if we don't have them in memory but they exist in session
        if (state.currentChoices == null && next.currentChoices != null && !state.isProcessing) {
          state = state.copyWith(currentChoices: next.currentChoices);
        }

        // Only update if data changed to avoid unnecessary state updates
        if (next.partner != state.partner || 
            next.user != state.user || 
            next.worldState != state.worldState) {
          
          state = state.copyWith(
            partner: next.partner,
            user: next.user,
            worldState: next.worldState,
            // Update image only if we don't have one or it changed externally
            lastImageUrl: next.images.isNotEmpty ? next.images.last.url : state.lastImageUrl,
          );
        }
      }
    });

    // Initial load try
    final session = ref.read(currentSessionProvider(sessionId));
    
    // Check if this is a fresh session (no messages)
    if (session != null && session.messages.isEmpty) {
      // Trigger PARTNER START flow on next frame
      Future.microtask(() => startNewSessionInteraction());
    }

    return ChatState(
      sessionId: sessionId,
      partner: session?.partner,
      user: session?.user,
      worldState: session?.worldState,
      currentChoices: session?.currentChoices, // Restore choices
      lastImageUrl: session?.images.isNotEmpty == true ? session!.images.last.url : null,
    );
  }

  // _loadSession is no longer strictly needed for initial load but kept for manual refresh if needed
  Future<void> _loadSession(String sessionId) async {
    final session = ref.read(currentSessionProvider(sessionId));
    if (session != null) {
      state = state.copyWith(
        partner: session.partner,
        user: session.user,
        worldState: session.worldState,
        lastImageUrl: session.images.isNotEmpty ? session.images.last.url : null,
      );
    }
  }

  Future<void> handleDirectInput(String input) async {
    state = state.copyWith(
      isProcessing: true,
      processingStage: ChatProcessingStage.partnerThinking, // Or a new stage 'Interpreting'?
      error: null,
    );

    try {
      final interpreter = ref.read(inputInterpreterAgentProvider);
      if (interpreter == null) throw Exception('Interpreter Agent not initialized');

      final partner = state.partner;
      final user = state.user;

      if (partner == null || user == null) {
        throw Exception('Session data missing for interpretation');
      }

      final choice = await interpreter.interpret(InputInterpreterInput(
        userInput: input,
        partner: partner,
        user: user,
      ));

      // Proceed with the interpreted choice
      await handleUserChoice(choice);
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Failed to interpret input: $e',
      );
    }
  }

  Future<void> handleUserChoice(StrategyChoice choice) async {
    state = state.copyWith(
      isProcessing: true,
      processingStage: ChatProcessingStage.partnerThinking,
      currentChoices: null,
      error: null,
    );

    // Clear persisted choices
    await ref.read(currentSessionProvider(state.sessionId).notifier).updateChoices(null);

    try {
      final partnerAgent = ref.read(partnerAgentProvider);
      final visualAgent = ref.read(visualDirectorAgentProvider);
      final strategistAgent = ref.read(strategistAgentProvider);
      final comfyService = ref.read(comfyUIServiceProvider);
      final storage = ref.read(storageServiceProvider);

      if (partnerAgent == null || visualAgent == null || strategistAgent == null) {
        throw Exception('Agents not initialized');
      }

      final partner = state.partner;
      final user = state.user;
      final worldState = state.worldState;

      if (partner == null || user == null || worldState == null) {
         // Try reloading if missing
         await _loadSession(state.sessionId);
         if (state.partner == null) throw Exception('Session data not loaded');
         // Retry with loaded data
         return handleUserChoice(choice);
      }

      // 0. Persist User Action
      final userMessage = ChatMessage(
        id: const Uuid().v4(),
        timestamp: DateTime.now(),
        type: MessageType.user,
        actions: choice.action != null ? [choice.action!] : null,
        dialogues: choice.speech != null ? [choice.speech!] : null,
      );
      
      await ref.read(currentSessionProvider(state.sessionId).notifier).addMessage(userMessage);

      // 1. Partner Agent
      final partnerResponse = await partnerAgent.generateResponse(
        user: user,
        partner: partner,
        worldState: worldState,
        history: ref.read(sessionMessagesProvider(state.sessionId)), 
        userInput: PartnerAgentInput(
          action: choice.action ?? '',
          speech: choice.speech ?? '',
          sdxlTags: choice.sdxlTags ?? '',
        ),
        scenarioNarration: '',
      );
      
      // Update partner state (emotional)
      // We should ideally merge this into the partner object in state
      // For now, let's update the session
      await ref.read(currentSessionProvider(state.sessionId).notifier).updatePartnerEmotionalState(
        partner.emotionalState.copyWith(
          affection: partner.emotionalState.affection + partnerResponse.emotionalChanges.affection,
          trust: partner.emotionalState.trust + partnerResponse.emotionalChanges.trust,
          arousal: partner.emotionalState.arousal + partnerResponse.emotionalChanges.arousal,
          lust: partner.emotionalState.lust + partnerResponse.emotionalChanges.lust,
          dominance: partner.emotionalState.dominance + partnerResponse.emotionalChanges.dominance,
          mood: partnerResponse.emotionalChanges.mood,
        )
      );

      // Refresh local state to get updated partner
      // Or manually update state.partner for immediate use
      final updatedPartner = partner.copyWith(
          emotionalState: partner.emotionalState.copyWith(
          affection: partner.emotionalState.affection + partnerResponse.emotionalChanges.affection,
          trust: partner.emotionalState.trust + partnerResponse.emotionalChanges.trust,
          arousal: partner.emotionalState.arousal + partnerResponse.emotionalChanges.arousal,
          lust: partner.emotionalState.lust + partnerResponse.emotionalChanges.lust,
          dominance: partner.emotionalState.dominance + partnerResponse.emotionalChanges.dominance,
          mood: partnerResponse.emotionalChanges.mood,
        )
      );
      
      state = state.copyWith(
        processingStage: ChatProcessingStage.visualDirectorWorking,
        partner: updatedPartner,
      );

      // 2.a Record Partner Message (Text Only)
      var partnerMessage = ChatMessage(
        id: const Uuid().v4(),
        timestamp: DateTime.now(),
        type: MessageType.partner,
        actions: partnerResponse.actions,
        dialogues: partnerResponse.dialogues,
        innerThought: partnerResponse.innerThought,
        imageId: null, // Image added later
      );
      await ref.read(currentSessionProvider(state.sessionId).notifier).addMessage(partnerMessage);

      // 3. Visual Director Agent
      final visualResponse = await visualAgent.generate(VisualDirectorInput(
        focusPoint: FocusPoint(
          userAction: UserAction(action: choice.action ?? '', sdxlTags: choice.sdxlTags ?? ''),
          partnerReaction: PartnerReaction(
            action: partnerResponse.actions.firstOrNull ?? '',
            physicalState: [], // partnerResponse.physicalStateChanges... need to map
            mood: partnerResponse.emotionalChanges.mood,
          ),
        ), 
        sceneContext: SceneContext(
          location: updatedPartner.location,
          timeOfDay: 'Evening', // TODO: Get from worldState
          weather: worldState.weather,
          emotionalAtmosphere: worldState.emotionalAtmosphere,
        ), 
        characters: CharacterVisuals(
          partner: PartnerVisuals(
            face: updatedPartner.face,
            hairstyle: updatedPartner.hairstyle,
            body: updatedPartner.body,
            accessories: updatedPartner.accessories,
            outfit: updatedPartner.outfit,
            isNSFWAllowed: updatedPartner.isNSFWAllowed,
            nsfwOutfit: updatedPartner.nsfwOutfit,
          ), 
          user: UserVisuals(
            face: user.face,
            hairstyle: user.hairstyle,
            body: user.body,
            accessories: user.accessories,
            outfit: user.outfit,
          )
        ), 
        modelPreset: BuiltInPresets.animeStyle, // TODO: Get from session
      ));
      
      state = state.copyWith(processingStage: ChatProcessingStage.imageGenerating);

      // 4. Generate Image
      // Check if we need image (VisualDirector usually always returns prompt, but maybe we optimize later)
      final positivePrompt = visualResponse.positiveTags.join(', ');
      
      GeneratedImageResult? imageResult;
      String? generatedImageId;
      try {
        imageResult = await comfyService.generateImage(
          positivePrompt: positivePrompt,
          negativePrompt: '', // Use preset default
          latentImageSize: ImageSize.portrait,
          modelPreset: BuiltInPresets.animeStyle, // TODO: Get from session
        );
        
        // Save Image & Update Message
        if (imageResult != null) {
           generatedImageId = const Uuid().v4();
           final generatedImage = GeneratedImage(
             id: generatedImageId!,
             url: imageResult.imageUrl,
             prompt: positivePrompt,
             createdAt: DateTime.now(),
           );
           await ref.read(currentSessionProvider(state.sessionId).notifier).addImage(generatedImage);

           // UPDATE PREVIOUS MESSAGE WITH IMAGE
           partnerMessage = partnerMessage.copyWith(imageId: generatedImageId);
           await ref.read(currentSessionProvider(state.sessionId).notifier).updateMessage(partnerMessage);
        }
      } catch (e) {
        print('Image generation failed: $e');
        // Continue even if image fails
      }
      
      state = state.copyWith(
        processingStage: ChatProcessingStage.strategistPlanning,
        lastImageUrl: imageResult?.imageUrl, 
      );

      // 5. Strategist Agent
      final strategistResponse = await strategistAgent.generate(StrategistAgentInput(
        partner: updatedPartner, 
        user: user, 
        worldState: worldState, 
        partnerLastResponse: partnerResponse, 
        history: ref.read(sessionMessagesProvider(state.sessionId))
      ));

      // 6. Complete
      state = state.copyWith(
        isProcessing: false,
        processingStage: ChatProcessingStage.completed,
        currentChoices: strategistResponse.choices,
      );

      // Persist Choices
      await ref.read(currentSessionProvider(state.sessionId).notifier).updateChoices(strategistResponse.choices);

      // Update turn count in world state
      final newWorldState = worldState.copyWith(turnCount: worldState.turnCount + 1);
      await ref.read(currentSessionProvider(state.sessionId).notifier).updateWorldState(newWorldState);
      state = state.copyWith(worldState: newWorldState);

    } catch (e, st) {
      print('Error in chat: $e\n$st');
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }

  /// Start a new session with Partner's initiative
  Future<void> startNewSessionInteraction() async {
    if (state.isProcessing) return;

    state = state.copyWith(
      isProcessing: true,
      processingStage: ChatProcessingStage.partnerThinking,
      error: null,
    );

    try {
      final partnerAgent = ref.read(partnerAgentProvider);
      final visualAgent = ref.read(visualDirectorAgentProvider);
      final strategistAgent = ref.read(strategistAgentProvider);
      final comfyService = ref.read(comfyUIServiceProvider);

      if (partnerAgent == null || visualAgent == null || strategistAgent == null) {
        throw Exception('Agents not initialized');
      }

      var partner = state.partner;
      final user = state.user;
      final worldState = state.worldState;

      if (partner == null || user == null || worldState == null) {
         await _loadSession(state.sessionId);
         partner = state.partner; // refresh local var
         if (state.partner == null) throw Exception('Session data not loaded');
      }

      // 1. Partner Agent (First Move)
      // Sending empty input to signify "Start of interaction"
      final partnerResponse = await partnerAgent.generateResponse(
        user: user!,
        partner: partner!,
        worldState: worldState!,
        history: [], 
        userInput: PartnerAgentInput(
          action: '',
          speech: '',
          sdxlTags: '',
        ),
        scenarioNarration: 'The story begins. The partner initiates the conversation.', 
      );
      
      // Update emotional state
      await ref.read(currentSessionProvider(state.sessionId).notifier).updatePartnerEmotionalState(
        partner.emotionalState.copyWith(
          affection: partner.emotionalState.affection + partnerResponse.emotionalChanges.affection,
          trust: partner.emotionalState.trust + partnerResponse.emotionalChanges.trust,
          arousal: partner.emotionalState.arousal + partnerResponse.emotionalChanges.arousal,
          lust: partner.emotionalState.lust + partnerResponse.emotionalChanges.lust,
          dominance: partner.emotionalState.dominance + partnerResponse.emotionalChanges.dominance,
          mood: partnerResponse.emotionalChanges.mood,
        )
      );

      // Refresh partner object for next steps
      partner = partner.copyWith(
           emotionalState: partner.emotionalState.copyWith(
          affection: partner.emotionalState.affection + partnerResponse.emotionalChanges.affection,
          trust: partner.emotionalState.trust + partnerResponse.emotionalChanges.trust,
          arousal: partner.emotionalState.arousal + partnerResponse.emotionalChanges.arousal,
          lust: partner.emotionalState.lust + partnerResponse.emotionalChanges.lust,
          dominance: partner.emotionalState.dominance + partnerResponse.emotionalChanges.dominance,
          mood: partnerResponse.emotionalChanges.mood,
        )
      );
      
      state = state.copyWith(
        processingStage: ChatProcessingStage.visualDirectorWorking,
        partner: partner,
      );

      // 1.a Record Partner Message (Text Only)
      var partnerMessage = ChatMessage(
        id: const Uuid().v4(),
        timestamp: DateTime.now(),
        type: MessageType.partner,
        actions: partnerResponse.actions,
        dialogues: partnerResponse.dialogues,
        innerThought: partnerResponse.innerThought,
        imageId: null, // Image added later
      );
      await ref.read(currentSessionProvider(state.sessionId).notifier).addMessage(partnerMessage);

      // 2. Visual Director
      final visualResponse = await visualAgent.generate(VisualDirectorInput(
        focusPoint: FocusPoint(
          userAction: UserAction(action: '', sdxlTags: ''),
          partnerReaction: PartnerReaction(
            action: partnerResponse.actions.firstOrNull ?? '',
            physicalState: [],
            mood: partnerResponse.emotionalChanges.mood,
          ),
        ), 
        sceneContext: SceneContext(
          location: partner.location,
          timeOfDay: 'Evening',
          weather: worldState.weather,
          emotionalAtmosphere: worldState.emotionalAtmosphere,
        ), 
        characters: CharacterVisuals(
          partner: PartnerVisuals(
            face: partner.face,
            hairstyle: partner.hairstyle,
            body: partner.body,
            accessories: partner.accessories,
            outfit: partner.outfit,
            isNSFWAllowed: partner.isNSFWAllowed,
            nsfwOutfit: partner.nsfwOutfit,
          ), 
          user: UserVisuals(
            face: user.face,
            hairstyle: user.hairstyle,
            body: user.body,
            accessories: user.accessories,
            outfit: user.outfit,
          )
        ), 
        modelPreset: BuiltInPresets.animeStyle,
      ));
      
      state = state.copyWith(processingStage: ChatProcessingStage.imageGenerating);

      // 3. Generate Image
      final positivePrompt = visualResponse.positiveTags.join(', ');
      GeneratedImageResult? imageResult;
      String? generatedImageId;
      
      try {
        imageResult = await comfyService.generateImage(
          positivePrompt: positivePrompt,
          negativePrompt: '',
          latentImageSize: ImageSize.portrait,
          modelPreset: BuiltInPresets.animeStyle,
        );
        
        if (imageResult != null) {
           generatedImageId = const Uuid().v4();
           final generatedImage = GeneratedImage(
             id: generatedImageId!,
             url: imageResult.imageUrl,
             prompt: positivePrompt,
             createdAt: DateTime.now(),
           );
           await ref.read(currentSessionProvider(state.sessionId).notifier).addImage(generatedImage);

           // UPDATE PREVIOUS MESSAGE WITH IMAGE
           partnerMessage = partnerMessage.copyWith(imageId: generatedImageId);
           await ref.read(currentSessionProvider(state.sessionId).notifier).updateMessage(partnerMessage);
        }
      } catch (e) {
        print('Image generation failed: $e');
      }
      
      state = state.copyWith(
        processingStage: ChatProcessingStage.strategistPlanning,
        lastImageUrl: imageResult?.imageUrl, 
      );

      // 5. Strategist Agent
      final strategistResponse = await strategistAgent.generate(StrategistAgentInput(
        partner: partner, 
        user: user, 
        worldState: worldState, 
        partnerLastResponse: partnerResponse, 
        history: [partnerMessage], 
      ));

      // 6. Complete
      state = state.copyWith(
        isProcessing: false,
        processingStage: ChatProcessingStage.completed,
        currentChoices: strategistResponse.choices,
      );

      // Persist Choices
      await ref.read(currentSessionProvider(state.sessionId).notifier).updateChoices(strategistResponse.choices);

    } catch (e, st) {
      print('Error in new session start: $e\n$st');
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh the choices (Run Strategist again)
  Future<void> refreshChoices() async {
    if (state.isProcessing) return;

    state = state.copyWith(
      isProcessing: true,
      processingStage: ChatProcessingStage.strategistPlanning,
    );

    try {
      final strategistAgent = ref.read(strategistAgentProvider);
      
      final partner = state.partner;
      final user = state.user;
      final worldState = state.worldState;
      final messages = ref.read(sessionMessagesProvider(state.sessionId));

      if (partner == null || user == null || worldState == null || messages.isEmpty) {
        throw Exception('Not enough context to refresh choices');
      }

      final lastMessage = messages.last;
      
      // Reconstruct partner response from last message
      // This is an approximation as we don't store the full response object
      final partnerLastResponse = PartnerResponse(
        actions: lastMessage.actions ?? [],
        dialogues: lastMessage.dialogues ?? [],
        innerThought: lastMessage.innerThought ?? '',
        emotionalChanges: const PartnerEmotionalState(
          affection: 0,
          trust: 0,
          arousal: 0,
          lust: 0,
          dominance: 0,
          mood: 'Neutral',
        ), 
        physicalStateChanges: const PhysicalStateChange(),
      );

      final strategistResponse = await strategistAgent?.generate(StrategistAgentInput(
        partner: partner, 
        user: user, 
        worldState: worldState, 
        partnerLastResponse: partnerLastResponse, 
        history: messages,
      ));

      if (strategistResponse == null) throw Exception('Strategist failed to generate');

      state = state.copyWith(
        isProcessing: false,
        processingStage: ChatProcessingStage.completed,
        currentChoices: strategistResponse.choices,
      );

      // Persist Choices
      await ref.read(currentSessionProvider(state.sessionId).notifier).updateChoices(strategistResponse.choices);

    } catch (e) {
      print('Error refreshing choices: $e');
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }
}
