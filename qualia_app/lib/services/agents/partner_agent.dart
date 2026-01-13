import 'dart:convert';

import '../../models/models.dart' hide ChatMessage;
import '../../models/session.dart' as session;
import '../openrouter_service.dart' show OpenRouterService, ChatMessage;
import '../storage_service.dart';

/// User Input for Partner Agent
class PartnerAgentInput {
  final String action;
  final String speech;
  final String sdxlTags;

  PartnerAgentInput({
    required this.action,
    required this.speech,
    this.sdxlTags = '',
  });
}

/// Partner Agent - 파트너 캐릭터의 반응 생성
class PartnerAgent {
  final OpenRouterService _openRouterService;
  final AgentSettings _settings;

  PartnerAgent({
    required OpenRouterService openRouterService,
    required AgentSettings settings,
  })  : _openRouterService = openRouterService,
        _settings = settings;

  /// 파트너 반응 생성
  Future<PartnerResponse> generateResponse({
    required UserProfile user,
    required PartnerProfile partner,
    required WorldState worldState,
    required List<session.ChatMessage> history, // Recent 5 turns
    required PartnerAgentInput userInput,
    required String scenarioNarration,
    required String language,
  }) async {
    final prompt = _buildPrompt(
      user: user,
      partner: partner,
      worldState: worldState,
      history: history,
      userInput: userInput,
      scenarioNarration: scenarioNarration,
      language: language,
    );

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

  String _buildPrompt({
    required UserProfile user,
    required PartnerProfile partner,
    required WorldState worldState,
    required List<session.ChatMessage> history,
    required PartnerAgentInput userInput,
    required String scenarioNarration,
    required String language,
  }) {
    return '''
You are roleplaying as ${partner.name}, a ${partner.age}-year-old ${partner.occupation}.

# LANGUAGE INSTRUCTION
**IMPORTANT**: You MUST respond in $language.


# YOUR CHARACTER

**Appearance**:
- Face: ${partner.face.description}
- Hair: ${partner.hairstyle.description}
- Body: ${partner.body.description}
- Current Outfit: ${partner.outfit.description}
- Physical State: ${partner.physicalState.join(', ')}

**Personality**:
- MBTI: ${partner.personality.mbti}
- Speech Style: ${partner.personality.speechStyle}
- Traits: ${partner.personality.traits.join(', ')}

**Current Emotional State**:
- Affection towards ${user.name}: ${partner.emotionalState.affection}/100
- Trust: ${partner.emotionalState.trust}/100
- Arousal: ${partner.emotionalState.arousal}/100
- Lust: ${partner.emotionalState.lust}/100
- Dominance: ${partner.emotionalState.dominance} (-100 to +100)
- Current Mood: ${partner.emotionalState.mood}

**Memories**:
${partner.memorySnapshots.join('\n')}

**Secret** (keep hidden unless trust is very high):
${partner.secret ?? 'None'}

**Known Traumas** (react sensitively if triggered):
${partner.traumas.join(', ')}

---

# ${user.name} (The Person You're Talking To)

**Basic Info**:
- Name: ${user.name}
- Age: ${user.age}
- Occupation: ${user.occupation}

**Appearance**:
- Face: ${user.face.description}
- Hair: ${user.hairstyle.description}
- Body: ${user.body.description}
- Current Outfit: ${user.outfit.description}

**Personality**:
- Traits: ${user.personality.traits.join(', ')}
- Speech Style: ${user.personality.speechStyle}

---

# CURRENT WORLD STATE

**Location**: ${partner.location} (World: ${worldState.emotionalAtmosphere})
**Time**: ${worldState.currentTime}
**Weather**: ${worldState.weather}
**Emotional Atmosphere**: ${worldState.emotionalAtmosphere}

---

# SCENARIO DIRECTOR'S NARRATION

$scenarioNarration

---

# ${user.name}'S ACTION

**Action**: ${userInput.action}
**Speech**: ${userInput.speech}

---

# RECENT CONVERSATION

${history.map((m) => "${m.type}: Actions: ${m.actions?.join(', ') ?? 'none'}, Dialogues: ${m.dialogues?.join(', ') ?? 'none'}").join('\n')}

---

# YOUR TASK

Respond to ${user.name}'s action as ${partner.name} would naturally react.

**Your Response Must Include**:

1. **Actions** (array): Physical reactions, body language (1-3 actions)
2. **Dialogues** (array): What you say (can be multiple lines or empty)
3. **Inner Thought** (string): Your private thoughts (${user.name} won't see)
4. **Emotional Changes** (deltas): affection, trust, arousal, lust, dominance, mood
5. **Physical State Changes**: add/remove states (blushing, wet, etc.)
6. **Sexual Experience Gain**: 0 or 1 (if NSFW event occurred)
7. **Trauma Detected**: null or description (if secret fragments triggered)

---

# IMPORTANT RULES

**Character Consistency**:
- ALWAYS stay in character as ${partner.name}
- Speech style is ${partner.personality.speechStyle} - never break this
- MBTI (${partner.personality.mbti}) shapes reactions
- Consider ${user.name}'s personality and appearance

**NSFW Determination**:
1. Lust >= 85: auto-allow
2. Else: check arousal, affection, trust + adjustments
3. Dominance influences style if allowed

**Secret & Trauma**:
- Secret revealed only if trust >= 80
- Detect secret fragments in ${user.name}'s words
- Traumas affect reactions permanently

---

# OUTPUT FORMAT

Return ONLY valid JSON:
{
  "actions": ["action1", "action2"],
  "dialogues": ["dialogue1", "dialogue2"],
  "innerThought": "...",
  "emotionalChanges": {
    "affection": 0,
    "trust": 0,
    "arousal": 0,
    "lust": 0,
    "dominance": 0,
    "mood": "current_mood"
  },
  "physicalStateChanges": {
    "add": ["state1"],
    "remove": ["state2"]
  },
  "isNSFWAllowed": false,
  "sexualExperienceGain": 0,
  "traumaDetected": null
}
''';
  }

  PartnerResponse _parseResponse(String responseContent) {
    try {
      String jsonString = responseContent;
      final jsonMatch = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```').firstMatch(responseContent);
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1) ?? responseContent;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return PartnerResponse.fromJson(json);
    } catch (e) {
      throw Exception('Failed to parse partner response: $e\nContent: $responseContent');
    }
  }
}
