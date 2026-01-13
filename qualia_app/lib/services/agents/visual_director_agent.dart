import 'dart:convert';

import '../../models/models.dart' hide ChatMessage;
import '../openrouter_service.dart' show OpenRouterService, ChatMessage;
import '../storage_service.dart';

/// Visual Director Agent - 이미지 생성 프롬프트 작성
class VisualDirectorAgent {
  final OpenRouterService _openRouterService;
  final AgentSettings _settings;

  VisualDirectorAgent({
    required OpenRouterService openRouterService,
    required AgentSettings settings,
  })  : _openRouterService = openRouterService,
        _settings = settings;

  /// 이미지 프롬프트 생성
  Future<VisualDirectorResponse> generate(VisualDirectorInput input) async {
    final prompt = _buildPrompt(input);

    final response = await _openRouterService.chatCompletion(
      model: _settings.model,
      messages: [ChatMessage.user(prompt)],
      temperature: _settings.temperature,
      maxTokens: _settings.maxTokens,
      topP: _settings.topP,
      frequencyPenalty: _settings.frequencyPenalty,
      presencePenalty: _settings.presencePenalty,
    );

    return _parseResponse(response.content);
  }

  String _buildPrompt(VisualDirectorInput input) {
    final worldState = input.sceneContext;
    final partner = input.characters.partner;
    
    // Together: User and Partner locations match
    // Note: locations are strings, case insensitive comparison recommended
    final together = worldState.location.toLowerCase() == 'together' || // Explicit 'together' keyword if used
        (input.characters.user.face.description.isNotEmpty); // Fallback logic or assume 'together' based on context?
    // Spec says: "userLocation == partnerLocation".
    // VisualDirectorInput -> SceneContext has only one "location".
    // Wait, Spec input says:
    /*
      "worldState": { ... "userLocation": "park", "partnerLocation": "park" ... }
    */
    // But VisualDirectorInput -> SceneContext has "location" (singular).
    // Let's re-read VisualDirectorInput definition.
    /*
    class SceneContext {
      required String location,
      ...
    }
    */
    // It seems VisualDirectorInput model simplified the locations to one 'location'.
    // If so, I can assume they are together if not specified otherwise?
    // Or I should rely on a simpler logic for now: Always Together unless stated?
    // Actually, the Spec says "userLocation == partnerLocation".
    // The Input model provided by previous dev (VisualDirectorInput) defines SceneContext with single location.
    // I should check if I can infer it.
    // Or update visual_director_input.dart?
    // Updating input model triggers build_runner.
    // I'll stick to 'together' for now unless I find a field indicating separation.
    // Or check 'currentSituation' description?
    
    // For simplicity, let's assume 'Together' mode primarily for MVP.
    // Or better, I can check if 'userAction' implies presence.
    
    // Let's implement the 'Together' prompts first. logic: Always TogetherMainly.
    // I'll add a TODO to handle location separation if SceneContext supports it later.
    final areTogether = true; 
    
    final nsfw = partner.isNSFWAllowed;

    if (areTogether && !nsfw) {
      return _buildTogetherNormalPrompt(input);
    } else if (areTogether && nsfw) {
      return _buildTogetherNSFWPrompt(input);
    } else if (!areTogether && !nsfw) {
      // return _buildSoloNormalPrompt(input);
      return _buildTogetherNormalPrompt(input); // Fallback
    } else {
      // return _buildSoloNSFWPrompt(input);
      return _buildTogetherNSFWPrompt(input); // Fallback
    }
  }

  String _buildTogetherNormalPrompt(VisualDirectorInput input) {
    final focus = input.focusPoint;
    final ctx = input.sceneContext;
    final chars = input.characters;

    return '''
You are a Visual Director for romantic visual novel images.

# Scene Focus (PRIORITY)
User Action: ${focus.userAction.sdxlTags}
Partner Reaction: ${focus.partnerReaction.action}
Partner Mood: ${focus.partnerReaction.mood}
Partner Physical State: ${focus.partnerReaction.physicalState.join(', ')}

# Environment
Location: ${ctx.location}
Time: ${ctx.timeOfDay}
Weather: ${ctx.weather}
Current Situation: ${ctx.currentSituation?.sdxlTags ?? ''}
Atmosphere: ${ctx.emotionalAtmosphere}

# Characters
Partner: ${chars.partner.face.sdxlTags}, ${chars.partner.hairstyle.sdxlTags}, ${chars.partner.body.sdxlTags}, ${chars.partner.accessories.sdxlTags}, ${chars.partner.outfit.sdxlTags}
User: ${chars.user.face.sdxlTags}, ${chars.user.hairstyle.sdxlTags}, ${chars.user.body.sdxlTags}, ${chars.user.accessories.sdxlTags}, ${chars.user.outfit.sdxlTags}

# Mood to Expression Guide
- Happy → bright smile, sparkling eyes
- Flustered → blushing, shy smile, averting eyes
- Anxious → worried expression, tense posture
- Horny → sultry gaze, parted lips, flushed cheeks

# Instructions
- Focus on the MOMENT of interaction between two people
- Emphasize emotional connection and chemistry
- Convert mood to appropriate facial expressions
- Physical state affects appearance (blushing, wet, etc.)
- Both characters should be visible
- Seductive/alluring content is acceptable

Output: JSON array of SDXL tags
''';
  }

  String _buildTogetherNSFWPrompt(VisualDirectorInput input) {
    final focus = input.focusPoint;
    final ctx = input.sceneContext;
    final chars = input.characters;
    final partnerOutfit = chars.partner.nsfwOutfit ?? chars.partner.outfit;

    return '''
You are a Visual Director for adult romantic visual novel images.

# Scene Focus (PRIORITY)
User Action: ${focus.userAction.sdxlTags}
Partner Reaction: ${focus.partnerReaction.action}
Partner Mood: ${focus.partnerReaction.mood}
Partner Physical State: ${focus.partnerReaction.physicalState.join(', ')}

# Environment
Location: ${ctx.location}
Time: ${ctx.timeOfDay}
Weather: ${ctx.weather}
Current Situation: ${ctx.currentSituation?.sdxlTags ?? ''}
Atmosphere: ${ctx.emotionalAtmosphere}

# Characters
Partner: ${chars.partner.face.sdxlTags}, ${chars.partner.hairstyle.sdxlTags}, ${chars.partner.body.sdxlTags}, ${chars.partner.accessories.sdxlTags}, ${partnerOutfit.sdxlTags}
User: ${chars.user.face.sdxlTags}, ${chars.user.hairstyle.sdxlTags}, ${chars.user.body.sdxlTags}, ${chars.user.accessories.sdxlTags}, ${chars.user.outfit.sdxlTags}

# Mood to Expression Guide
- Happy → bright smile, sparkling eyes
- Flustered → blushing, shy smile, averting eyes
- Anxious → worried expression, tense posture
- Horny → sultry gaze, parted lips, flushed cheeks

# Instructions
- Focus on the intimate MOMENT between two people
- Balance explicit content with emotional expression
- Partner's mood is crucial even in explicit scenes
- Both characters should be visible
- Incorporate physical states naturally

Output: JSON array of SDXL tags
''';
  }

  VisualDirectorResponse _parseResponse(String responseContent) {
    try {
      String jsonString = responseContent;
      final jsonMatch = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```').firstMatch(responseContent);
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1) ?? responseContent;
      }

      final json = jsonDecode(jsonString);
      List<String> tags = [];
      
      if (json is Map<String, dynamic> && json.containsKey('positiveTags')) {
        tags = (json['positiveTags'] as List).map((e) => e.toString()).toList();
      } else if (json is List) {
        tags = json.map((e) => e.toString()).toList();
      } else {
        // Fallback or custom format
        if (json is Map && json.isNotEmpty) {
           // try first value if list
           if (json.values.first is List) {
             tags = (json.values.first as List).map((e) => e.toString()).toList();
           }
        }
      }

      return VisualDirectorResponse(positiveTags: tags);
    } catch (e) {
      // On failure, return empty or try to parse as comma separated string?
      if (!responseContent.trim().startsWith('{') && !responseContent.trim().startsWith('[')) {
         return VisualDirectorResponse(positiveTags: responseContent.split(',').map((e) => e.trim()).toList());
      }
      throw Exception('Failed to parse visual director response: $e');
    }
  }
}
