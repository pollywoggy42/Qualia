import 'dart:convert';

import '../../models/partner_profile.dart';
import '../../models/visual_descriptor.dart';
import '../../models/personality.dart';
import '../../models/partner_emotional_state.dart';
import '../../models/world_state.dart';
import '../openrouter_service.dart';
import '../storage_service.dart';

/// ScenarioGenerator Agent - 초기 시나리오 및 파트너 프로필 생성
class ScenarioGeneratorAgent {
  final OpenRouterService _openRouterService;
  final AgentSettings _settings;

  ScenarioGeneratorAgent({
    required OpenRouterService openRouterService,
    required AgentSettings settings,
  })  : _openRouterService = openRouterService,
        _settings = settings;

  /// 시나리오와 파트너 프로필 생성
  Future<ScenarioGenerationResult> generate({
    required String userGender,
    required String partnerGender,
    String? theme,
    String? setting,
  }) async {
    final prompt = _buildPrompt(
      userGender: userGender,
      partnerGender: partnerGender,
      theme: theme,
      setting: setting,
    );

    final response = await _openRouterService.chatCompletion(
      model: _settings.model,
      messages: [ChatMessage.user(prompt)],
      temperature: _settings.temperature,
      maxTokens: _settings.maxTokens,
      topP: _settings.topP,
      frequencyPenalty: _settings.frequencyPenalty,
      presencePenalty: _settings.presencePenalty,
      systemPrompt: _systemPrompt,
    );

    return _parseResponse(response.content);
  }

  String _buildPrompt({
    required String userGender,
    required String partnerGender,
    String? theme,
    String? setting,
  }) {
    return '''
Generate a romantic scenario and partner profile with the following requirements:

**User Profile:**
- Gender: $userGender

**Partner Requirements:**
- Gender: $partnerGender
${theme != null ? '- Theme/Genre: $theme' : ''}
${setting != null ? '- Setting: $setting' : ''}

Generate a complete partner profile and initial scenario. Be creative and detailed.
The scenario should be the first moment of encounter.

Respond in the exact JSON format specified in the system prompt.
''';
  }

  static const String _systemPrompt = '''
You are a creative writer specializing in romantic visual novel scenarios.
Generate unique, engaging scenarios with well-developed characters.

Your response MUST be valid JSON in this exact format:
{
  "partner": {
    "name": "Character name",
    "age": 25,
    "gender": "female/male/other",
    "occupation": "Their job or role",
    "location": "Where you meet them",
    "face": {
      "description": "Natural language description of their face",
      "sdxlTags": "comma, separated, sdxl, tags, for, face"
    },
    "hairstyle": {
      "description": "Natural language description of hairstyle",
      "sdxlTags": "comma, separated, sdxl, tags"
    },
    "body": {
      "description": "Body type description",
      "sdxlTags": "comma, separated, sdxl, tags"
    },
    "accessories": {
      "description": "What accessories they wear",
      "sdxlTags": "comma, separated, sdxl, tags"
    },
    "outfit": {
      "description": "What they're wearing",
      "sdxlTags": "comma, separated, sdxl, tags"
    },
    "personality": {
      "mbti": "XXXX",
      "speechStyle": "How they talk",
      "traits": ["trait1", "trait2", "trait3"]
    },
    "secret": "A hidden truth about them that will be revealed over time",
    "emotionalState": {
      "trust": 30,
      "attraction": 20,
      "comfort": 40,
      "mood": "curious/happy/nervous/etc"
    }
  },
  "scenario": {
    "title": "Scenario title",
    "setting": "Description of where and when",
    "openingNarration": "The narrative text describing the scene (2-3 paragraphs)",
    "partnerFirstLine": "What the partner says first"
  },
  "worldState": {
    "currentLocation": "Location name",
    "timeOfDay": "morning/afternoon/evening/night",
    "weather": "Weather condition",
    "atmosphere": "The overall mood"
  }
}

Guidelines:
- Create believable, three-dimensional characters
- The secret should be meaningful but not dark/traumatic
- SDXL tags should be specific and useful for image generation
- Opening narration should set the mood and describe the first encounter
- The partner's first line should invite interaction
''';

  ScenarioGenerationResult _parseResponse(String responseContent) {
    try {
      // Extract JSON from response (handle markdown code blocks)
      String jsonString = responseContent;

      // Remove markdown code block if present
      final jsonMatch = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```').firstMatch(responseContent);
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1) ?? responseContent;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;

      final partnerJson = json['partner'] as Map<String, dynamic>;
      final scenarioJson = json['scenario'] as Map<String, dynamic>;
      final worldStateJson = json['worldState'] as Map<String, dynamic>;

      final partner = PartnerProfile(
        name: partnerJson['name'] as String,
        age: partnerJson['age'] as int,
        gender: partnerJson['gender'] as String,
        occupation: partnerJson['occupation'] as String,
        location: partnerJson['location'] as String,
        face: _parseVisualDescriptor(partnerJson['face']),
        hairstyle: _parseVisualDescriptor(partnerJson['hairstyle']),
        body: _parseVisualDescriptor(partnerJson['body']),
        accessories: _parseVisualDescriptor(partnerJson['accessories']),
        outfit: _parseVisualDescriptor(partnerJson['outfit']),
        personality: _parsePersonality(partnerJson['personality']),
        secret: partnerJson['secret'] as String?,
        secretFragments: [],
        traumas: [],
        emotionalState: _parseEmotionalState(partnerJson['emotionalState']),
        physicalState: [],
        sexualExperience: 0,
        isNSFWAllowed: false,
        memorySnapshots: [],
      );

      final scenario = ScenarioInfo(
        title: scenarioJson['title'] as String,
        setting: scenarioJson['setting'] as String,
        openingNarration: scenarioJson['openingNarration'] as String,
        partnerFirstLine: scenarioJson['partnerFirstLine'] as String,
      );

      final worldState = WorldState(
        currentTime: DateTime.now(),
        weather: worldStateJson['weather'] as String? ?? 'clear',
        emotionalAtmosphere: worldStateJson['atmosphere'] as String? ?? 'Neutral',
      );

      return ScenarioGenerationResult(
        partner: partner,
        scenario: scenario,
        worldState: worldState,
      );
    } catch (e) {
      throw ScenarioGenerationException(
        'Failed to parse scenario response: $e',
        responseContent,
      );
    }
  }

  VisualDescriptor _parseVisualDescriptor(Map<String, dynamic> json) {
    return VisualDescriptor(
      description: json['description'] as String,
      sdxlTags: json['sdxlTags'] as String,
    );
  }

  Personality _parsePersonality(Map<String, dynamic> json) {
    return Personality(
      mbti: json['mbti'] as String,
      speechStyle: json['speechStyle'] as String,
      traits: (json['traits'] as List).map((e) => e as String).toList(),
    );
  }

  PartnerEmotionalState _parseEmotionalState(Map<String, dynamic> json) {
    return PartnerEmotionalState(
      affection: json['attraction'] as int? ?? 50,
      trust: json['trust'] as int? ?? 50,
      mood: json['mood'] as String? ?? 'Neutral',
    );
  }
}

/// 시나리오 생성 결과
class ScenarioGenerationResult {
  final PartnerProfile partner;
  final ScenarioInfo scenario;
  final WorldState worldState;

  ScenarioGenerationResult({
    required this.partner,
    required this.scenario,
    required this.worldState,
  });
}

/// 시나리오 정보
class ScenarioInfo {
  final String title;
  final String setting;
  final String openingNarration;
  final String partnerFirstLine;

  ScenarioInfo({
    required this.title,
    required this.setting,
    required this.openingNarration,
    required this.partnerFirstLine,
  });
}

/// 시나리오 생성 예외
class ScenarioGenerationException implements Exception {
  final String message;
  final String? responseContent;

  ScenarioGenerationException(this.message, [this.responseContent]);

  @override
  String toString() => 'ScenarioGenerationException: $message';
}
