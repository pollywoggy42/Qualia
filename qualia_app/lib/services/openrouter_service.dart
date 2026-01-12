import 'dart:convert';
import 'package:http/http.dart' as http;

/// OpenRouter API Service - LLM 호출을 위한 서비스
class OpenRouterService {
  static const String _baseUrl = 'https://openrouter.ai/api/v1';

  final String _apiKey;
  final http.Client _client;

  OpenRouterService({
    required String apiKey,
    http.Client? client,
  })  : _apiKey = apiKey,
        _client = client ?? http.Client();

  /// Chat completion 요청
  Future<ChatCompletionResponse> chatCompletion({
    required String model,
    required List<ChatMessage> messages,
    double temperature = 0.7,
    int? maxTokens,
    double? topP,
    double? frequencyPenalty,
    double? presencePenalty,
    List<String>? stop,
    String? systemPrompt,
  }) async {
    final requestMessages = <Map<String, String>>[];

    if (systemPrompt != null) {
      requestMessages.add({
        'role': 'system',
        'content': systemPrompt,
      });
    }

    for (final message in messages) {
      requestMessages.add({
        'role': message.role,
        'content': message.content,
      });
    }

    final body = {
      'model': model,
      'messages': requestMessages,
      'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (topP != null) 'top_p': topP,
      if (frequencyPenalty != null) 'frequency_penalty': frequencyPenalty,
      if (presencePenalty != null) 'presence_penalty': presencePenalty,
      if (stop != null && stop.isNotEmpty) 'stop': stop,
    };

    final response = await _client.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://qualia.app',
        'X-Title': 'Qualia',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw OpenRouterException(
        'API request failed: ${response.statusCode}',
        response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return ChatCompletionResponse.fromJson(json);
  }

  /// API 키 검증 및 크레딧 잔액 조회
  Future<AccountInfo> verifyApiKey() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/auth/key'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
      },
    );

    if (response.statusCode != 200) {
      throw OpenRouterException(
        'API key verification failed: ${response.statusCode}',
        response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AccountInfo.fromJson(json['data'] as Map<String, dynamic>);
  }

  /// 사용 가능한 모델 목록 조회
  Future<List<ModelInfo>> getModels() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/models'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
      },
    );

    if (response.statusCode != 200) {
      throw OpenRouterException(
        'Failed to get models: ${response.statusCode}',
        response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List;
    return data
        .map((m) => ModelInfo.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  void dispose() {
    _client.close();
  }
}

/// Chat Message
class ChatMessage {
  final String role;
  final String content;

  ChatMessage({
    required this.role,
    required this.content,
  });

  factory ChatMessage.user(String content) =>
      ChatMessage(role: 'user', content: content);

  factory ChatMessage.assistant(String content) =>
      ChatMessage(role: 'assistant', content: content);
}

/// Chat Completion Response
class ChatCompletionResponse {
  final String id;
  final String content;
  final Usage usage;

  ChatCompletionResponse({
    required this.id,
    required this.content,
    required this.usage,
  });

  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) {
    final choices = json['choices'] as List;
    final firstChoice = choices.first as Map<String, dynamic>;
    final message = firstChoice['message'] as Map<String, dynamic>;

    return ChatCompletionResponse(
      id: json['id'] as String,
      content: message['content'] as String,
      usage: Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );
  }
}

/// Usage info
class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'] as int,
      completionTokens: json['completion_tokens'] as int,
      totalTokens: json['total_tokens'] as int,
    );
  }
}

/// Account Info
class AccountInfo {
  final String label;
  final double creditBalance;
  final int rateLimit;

  AccountInfo({
    required this.label,
    required this.creditBalance,
    required this.rateLimit,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      label: json['label'] as String? ?? '',
      creditBalance: (json['limit'] as num?)?.toDouble() ?? 0.0,
      rateLimit: json['rate_limit'] as int? ?? 0,
    );
  }
}

/// Model Info
class ModelInfo {
  final String id;
  final String name;
  final double promptPricing;
  final double completionPricing;
  final int contextLength;

  ModelInfo({
    required this.id,
    required this.name,
    required this.promptPricing,
    required this.completionPricing,
    required this.contextLength,
  });

  factory ModelInfo.fromJson(Map<String, dynamic> json) {
    final pricing = json['pricing'] as Map<String, dynamic>?;
    return ModelInfo(
      id: json['id'] as String,
      name: json['name'] as String? ?? json['id'] as String,
      promptPricing: double.tryParse(pricing?['prompt']?.toString() ?? '0') ?? 0,
      completionPricing: double.tryParse(pricing?['completion']?.toString() ?? '0') ?? 0,
      contextLength: json['context_length'] as int? ?? 0,
    );
  }
}

/// OpenRouter Exception
class OpenRouterException implements Exception {
  final String message;
  final String? responseBody;

  OpenRouterException(this.message, [this.responseBody]);

  @override
  String toString() => 'OpenRouterException: $message';
}
