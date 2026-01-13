import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';
import 'partner_agent_provider.dart';
import 'visual_director_agent_provider.dart';
import 'strategist_agent_provider.dart';
import 'comfyui_provider.dart';
import 'storage_provider.dart';
import '../services/agents/partner_agent.dart';
import '../services/agents/strategist_agent.dart';

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
  final List<dynamic> messages; // TODO: Define unified message model for UI
  final bool isProcessing;
  final ChatProcessingStage processingStage;
  final List<StrategyChoice>? currentChoices;
  final PartnerProfile? partner;
  final WorldState? worldState;
  final String? lastImageUrl;
  final String? error;

  ChatState({
    this.messages = const [],
    this.isProcessing = false,
    this.processingStage = ChatProcessingStage.idle,
    this.currentChoices,
    this.partner,
    this.worldState,
    this.lastImageUrl,
    this.error,
  });

  ChatState copyWith({
    List<dynamic>? messages,
    bool? isProcessing,
    ChatProcessingStage? processingStage,
    List<StrategyChoice>? currentChoices,
    PartnerProfile? partner,
    WorldState? worldState,
    String? lastImageUrl,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isProcessing: isProcessing ?? this.isProcessing,
      processingStage: processingStage ?? this.processingStage,
      currentChoices: currentChoices ?? this.currentChoices,
      partner: partner ?? this.partner,
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
    _loadSession(sessionId);
    return ChatState(); // Empty initially
  }

  Future<void> _loadSession(String sessionId) async {
    // TODO: Load from storage
    // Mocking for now as requested by user plan (basic loop)
    state = state.copyWith(
      worldState: WorldState(
        currentTime: DateTime.now(),
        weather: 'Rainy',
        emotionalAtmosphere: 'Romantic',
      ),
      // Partner mock needs to be loaded ideally
    );
  }
  
  // Set Mock Data for testing (until Storage logic integrated)
  void setMockData(PartnerProfile partner, UserProfile user) {
    state = state.copyWith(partner: partner);
  }

  Future<void> handleUserChoice(StrategyChoice choice) async {
    state = state.copyWith(
      isProcessing: true,
      processingStage: ChatProcessingStage.partnerThinking,
      currentChoices: null,
      error: null,
    );

    try {
      final partnerAgent = ref.read(partnerAgentProvider);
      final visualAgent = ref.read(visualDirectorAgentProvider);
      final strategistAgent = ref.read(strategistAgentProvider);
      final comfyService = ref.read(comfyUIServiceProvider);
      final storage = ref.read(storageServiceProvider);

      if (partnerAgent == null || visualAgent == null || strategistAgent == null) {
        throw Exception('Agents not initialized');
      }

      // Mock Data (Replace with real data from state/storage)
      // TODO: Implement getUserProfile in storage
      final user = UserProfile(
        name: 'User', 
        age: 25, 
        gender: 'Male', 
        occupation: 'Student', 
        location: 'Park', 
        face: const VisualDescriptor(description: 'Average', sdxlTags: '1boy'), 
        hairstyle: const VisualDescriptor(description: 'Short', sdxlTags: 'short hair'), 
        body: const VisualDescriptor(description: 'Average', sdxlTags: 'average body'), 
        accessories: const VisualDescriptor(description: 'None', sdxlTags: ''), 
        outfit: const VisualDescriptor(description: 'Casual', sdxlTags: 'casual clothes'), 
        personality: const Personality(mbti: 'ISTJ', speechStyle: 'Polite', traits: []),
      ); 
      
      final partner = state.partner; 

      if (partner == null) {
         throw Exception('Partner not loaded');
      }

      // 1. Partner Agent
      final partnerResponse = await partnerAgent.generateResponse(
        user: user,
        partner: partner,
        worldState: state.worldState!,
        history: [], // TODO: Get history
        userInput: PartnerAgentInput(
          action: choice.action ?? '',
          speech: choice.speech ?? '',
          sdxlTags: choice.sdxlTags ?? '',
        ),
        scenarioNarration: '',
      );
      
      state = state.copyWith(processingStage: ChatProcessingStage.visualDirectorWorking);

      // 2. Visual Director Agent
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
          location: partner.location,
          timeOfDay: 'Evening', 
          weather: 'Clear',
          emotionalAtmosphere: 'Romantic',
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
        modelPreset: BuiltInPresets.animeStyle, // Default
      ));
      
      state = state.copyWith(processingStage: ChatProcessingStage.imageGenerating);

      // 3. Generate Image
      final positivePrompt = visualResponse.positiveTags.join(', ');
      final imageResult = await comfyService.generateImage(
        positivePrompt: positivePrompt,
        negativePrompt: '', // Use preset default
        latentImageSize: ImageSize.portrait,
        modelPreset: BuiltInPresets.animeStyle, // Should match input
      );
      
      state = state.copyWith(
        processingStage: ChatProcessingStage.strategistPlanning,
        lastImageUrl: imageResult.imageUrl, // Or use filename to construct local URL
      );

      // 4. Strategist Agent
      final strategistResponse = await strategistAgent.generate(StrategistAgentInput(
        partner: partner, 
        user: user, 
        worldState: state.worldState!, 
        partnerLastResponse: partnerResponse, 
        history: []
      ));

      // 5. Complete
      state = state.copyWith(
        isProcessing: false,
        processingStage: ChatProcessingStage.completed,
        currentChoices: strategistResponse.choices,
      );

    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }
}
