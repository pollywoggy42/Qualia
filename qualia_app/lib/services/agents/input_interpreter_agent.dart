import 'dart:convert';

import '../../models/models.dart' hide ChatMessage;
import '../storage_service.dart';
import '../openrouter_service.dart';

class InputInterpreterInput {
  final String userInput;
  final PartnerProfile partner;
  final UserProfile user;

  InputInterpreterInput({
    required this.userInput,
    required this.partner,
    required this.user,
  });
}

class InputInterpreterAgent {
  final OpenRouterService _openRouterService;
  final AgentSettings _settings;

  InputInterpreterAgent({
    required OpenRouterService openRouterService,
    required AgentSettings settings,
  })  : _openRouterService = openRouterService,
        _settings = settings;

  Future<StrategyChoice> interpret(InputInterpreterInput input) async {
    final prompt = _buildPrompt(input);

    final response = await _openRouterService.chatCompletion(
      model: _settings.model,
      messages: [ChatMessage.user(prompt)],
      temperature: 0.3, // Lower temperature for more deterministic parsing
      maxTokens: 500,
    );

    return _parseResponse(response.content);
  }

  String _buildPrompt(InputInterpreterInput input) {
    return '''
You are an interpreter for a roleplay visual novel.
Your job is to convert the User's natural language input into a structured action format.

# Context
User: ${input.user.name}
Partner: ${input.partner.name}

# User Input
"${input.userInput}"

# Task
Analyze the input and split it into:
1. Action: Physical actions, gestures, descriptions (3rd person perspective preferred for consistency, e.g. "holds her hand")
2. Speech: Spoken dialogue (what is inside quotes or implied speech)
3. SDXL Tags: Visual tags for generating an image of this moment (Danbooru style)

# Output Format (JSON)
{
  "action": "...",
  "speech": "...",
  "sdxlTags": "..."
}

# Rules
- If input is only speech, infer a neutral or context-appropriate mild action if possible, or leave action empty.
- If input is only action, leave speech empty.
- SDXL Tags should describe the USER's action and the interaction.
- KEEP IT CONCISE.
''';
  }

  StrategyChoice _parseResponse(String content) {
    try {
      String jsonString = content;
      final jsonMatch = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```').firstMatch(content);
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1) ?? content;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;

      return StrategyChoice(
        action: json['action'] as String? ?? '',
        speech: json['speech'] as String?,
        sdxlTags: json['sdxlTags'] as String? ?? '',
        successRate: 100, // Direct input always succeeds
        reasoning: 'Direct User Input',
        isSpecial: false,
      );
    } catch (e) {
      // Fallback if parsing fails - treat entire input as action or speech
      final isSpeech = content.trim().startsWith('"') || content.trim().contains('"');
      return StrategyChoice(
        action: isSpeech ? '' : content,
        speech: isSpeech ? content.replaceAll('"', '') : null,
        sdxlTags: 'talking', // Generic fallback
        successRate: 100,
        reasoning: 'Fallback Parsing',
        isSpecial: false,
      );
    }
  }
}
