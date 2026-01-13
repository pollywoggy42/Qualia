import 'dart:convert';

import '../../models/models.dart' hide ChatMessage;
import '../openrouter_service.dart' show OpenRouterService, ChatMessage;
import '../storage_service.dart';

/// Strategist Agent Input
class StrategistAgentInput {
  final PartnerProfile partner;
  final UserProfile user;
  final WorldState worldState;
  final PartnerResponse partnerLastResponse;
  final List<ChatMessage> history;

  StrategistAgentInput({
    required this.partner,
    required this.user,
    required this.worldState,
    required this.partnerLastResponse,
    required this.history,
  });
}

/// Strategist Agent - 유저 선택지 생성
class StrategistAgent {
  final OpenRouterService _openRouterService;
  final AgentSettings _settings;

  StrategistAgent({
    required OpenRouterService openRouterService,
    required AgentSettings settings,
  })  : _openRouterService = openRouterService,
        _settings = settings;

  /// 선택지 생성
  Future<StrategistResponse> generate(StrategistAgentInput input) async {
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

  String _buildPrompt(StrategistAgentInput input) {
    // Determine prompt type based on location and NSFW status
    final together = true; // Simplified for now - both in same location
    final nsfw = input.partner.isNSFWAllowed;

    if (together && !nsfw) {
      return _buildTogetherNormalPrompt(input);
    } else if (together && nsfw) {
      return _buildTogetherNSFWPrompt(input);
    } else if (!together && !nsfw) {
      // return _buildSoloNormalPrompt(input);
      return _buildTogetherNormalPrompt(input); // Fallback
    } else {
      // return _buildSoloNSFWPrompt(input);
      return _buildTogetherNSFWPrompt(input); // Fallback
    }
  }

  String _buildTogetherNormalPrompt(StrategistAgentInput input) {
    final p = input.partner;
    final u = input.user;
    final ws = input.worldState;
    final lr = input.partnerLastResponse;

    return '''
You are a Strategist for a romantic visual novel.

# Partner Information
Name: ${p.name}, ${p.age}, ${p.occupation}
Appearance:
- Face: ${p.face.description}
- Hair: ${p.hairstyle.description}
- Body: ${p.body.description}
- Outfit: ${p.outfit.description}
- Physical State: ${p.physicalState.join(', ')}

Emotional State:
- Affection: ${p.emotionalState.affection}
- Trust: ${p.emotionalState.trust}
- Arousal: ${p.emotionalState.arousal}
- Lust: ${p.emotionalState.lust}
- Mood: ${p.emotionalState.mood}

# User Information
Name: ${u.name}
Outfit: ${u.outfit.description}


Weather: ${ws.weather}
Atmosphere: ${ws.emotionalAtmosphere}

# Recent Context
Partner's Last Response actions: ${lr.actions.join(', ')}
Partner's Last Response dialogues: ${lr.dialogues.join(', ')}
Recent Conversation: ${input.history.length} turns

# Generate 5 Choices

4 Regular Choices:
- Use current situation, time, weather, outfit, physical state
- Range from safe emotional to bold physical
- Can be action-only, speech-only, or both
- Make them feel natural to THIS moment
- Both characters are present

1 Special Choice (conditional):
IF lust >= 60: Romantic escalation (kiss, embrace)
ELSE: Creative/unexpected option

# Output Format
{
  "choices": [
    {
      "action": "..." or null,
      "speech": "..." or null,
      "sdxlTags": "...",
      "successRate": 0-100,
      "reasoning": "...",
      "isSpecial": true/false
    }
  ]
}

# Important
- Keep it romantic and wholesome
- Seductive/alluring is OK, but not explicit
- Use Danbooru tag format (lowercase, underscores)
''';
  }

  String _buildTogetherNSFWPrompt(StrategistAgentInput input) {
    final p = input.partner;
    final u = input.user;
    final ws = input.worldState;
    final lr = input.partnerLastResponse;
    final outfit = p.nsfwOutfit ?? p.outfit;

    return '''
You are a Strategist for an adult romantic visual novel.

# Partner Information
Name: ${p.name}, ${p.age}, ${p.occupation}
Appearance:
- Face: ${p.face.description}
- Hair: ${p.hairstyle.description}
- Body: ${p.body.description}
- Outfit: ${outfit.description}
- Physical State: ${p.physicalState.join(', ')}

Emotional State:
- Affection: ${p.emotionalState.affection}
- Trust: ${p.emotionalState.trust}
- Arousal: ${p.emotionalState.arousal}
- Lust: ${p.emotionalState.lust}
- Mood: ${p.emotionalState.mood}

# User Information
Name: ${u.name}
Outfit: ${u.outfit.description}


Weather: ${ws.weather}
Atmosphere: ${ws.emotionalAtmosphere}

# Recent Context
Partner's Last Response actions: ${lr.actions.join(', ')}
Partner's Last Response dialogues: ${lr.dialogues.join(', ')}

# POSITION & ACT REFERENCE (Select 5 DIFFERENT acts per response)
- Standard: 69, amazon, boy_on_top, cowgirl, girl_on_top, lotus, missionary, mounting, reverse_cowgirl, scissors, spooning, standing_missionary, standing_sex, spitroast
- Rear-entry: doggystyle, air_doggystyle, arm_pulling_doggystyle, bent_over, downward_dog, prone_bone, reverse_standing_fuck, sex_from_behind
- Intense/Dominant: mating_press, piledriver, full_nelson, legs_behind_head, open_leg_missionary, praying_mantis
- Non-penetrative: armpit_sex, buttjob, footjob, female_footjob, frottage, groping, hairjob, handjob, hotdogging, intercrural_sex, paizuri, sumata, thigh_sex

# Generate 5 Choices

4 Regular Choices:
- Use positions/acts from reference above
- Match intensity to current lust level
- Can be action-only, speech-only, or both
- Balance physical intimacy with emotional connection
- Both characters are present

1 Special Choice:
IF lust >= 80: Intense option from reference
ELSE: Creative interaction

# Output Format
{
  "choices": [
    {
      "action": "..." or null,
      "speech": "..." or null,
      "sdxlTags": "...",
      "successRate": 0-100,
      "reasoning": "...",
      "isSpecial": true/false
    }
  ]
}

# Important
- Use exact tags from POSITION & ACT REFERENCE
- Maintain emotional authenticity even in explicit scenes
''';
  }

  StrategistResponse _parseResponse(String responseContent) {
    try {
      String jsonString = responseContent;
      final jsonMatch = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```').firstMatch(responseContent);
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1) ?? responseContent;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Handle "choices" array wrapper if present, implied by StrategistResponse structure
      return StrategistResponse.fromJson(json);
    } catch (e) {
      throw Exception('Failed to parse strategist response: $e\nContent: $responseContent');
    }
  }
}
