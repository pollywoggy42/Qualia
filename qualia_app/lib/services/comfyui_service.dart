import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/comfyui_model_preset.dart';

/// ComfyUI Service - 이미지 생성을 위한 서비스
class ComfyUIService {
  final String _host;
  final int _port;
  final http.Client _client;

  WebSocketChannel? _wsChannel;
  StreamController<ComfyUIProgress>? _progressController;

  ComfyUIService({
    required String host,
    required int port,
    http.Client? client,
  })  : _host = host,
        _port = port,
        _client = client ?? http.Client();

  /// Check if host is a full URL (e.g., https://abc.ngrok.io)
  bool get _isFullUrl => _host.startsWith('http://') || _host.startsWith('https://');

  String get _baseUrl => _isFullUrl ? _host : 'http://$_host:$_port';
  String get _wsUrl {
    if (_isFullUrl) {
      // Convert http(s):// to ws(s)://
      final wsHost = _host.replaceFirst('https://', 'wss://').replaceFirst('http://', 'ws://');
      return '$wsHost/ws';
    }
    return 'ws://$_host:$_port/ws';
  }

  Map<String, String> get _headers {
    if (_host.contains('ngrok')) {
      return {'ngrok-skip-browser-warning': 'true'};
    }
    return {};
  }

  /// 연결 테스트
  Future<bool> testConnection() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/system_stats'),
        headers: _headers,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out after 10 seconds');
        },
      );

      return response.statusCode == 200;
    } on TimeoutException catch (e) {
      print('❌ ComfyUI Connection Timeout: $e');
      rethrow;
    } catch (e) {
      print('❌ ComfyUI Connection Error: $e');
      
      if (kIsWeb) {
        // Check for potential Mixed Content issue
        if (_baseUrl.startsWith('http://')) {
          print('⚠️ WEB MIXED CONTENT ISSUE DETECTED');
          throw ComfyUIException(
            'Cannot connect to HTTP server from HTTPS app (Mixed Content).\n'
            'Please use HTTPS (e.g., ngrok, cloudflare) for your ComfyUI server.',
          );
        }
        
        // CORS hint
        print('⚠️ WEB CORS ISSUE LIKELY');
        throw ComfyUIException(
          'Connection failed. This is likely a CORS issue.\n'
          'Run ComfyUI with: --enable-cors-header "*"',
        );
      }
      
      return false;
    }
  }

  /// 시스템 정보 조회
  Future<SystemStats> getSystemStats() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/system_stats'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw ComfyUIException('Failed to get system stats: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SystemStats.fromJson(json);
  }

  /// 이미지 생성
  Future<GeneratedImageResult> generateImage({
    required String positivePrompt,
    required String negativePrompt,
    required ImageSize latentImageSize,
    required ComfyUIModelPreset modelPreset,
    int? seed,
  }) async {
    final clientId = DateTime.now().millisecondsSinceEpoch.toString();

    // Build workflow based on preset category
    final workflow = _buildWorkflow(
      positivePrompt: positivePrompt,
      negativePrompt: negativePrompt,
      latentImageSize: latentImageSize,
      modelPreset: modelPreset,
      seed: seed ?? _generateRandomSeed(),
    );

    // Connect to WebSocket FIRST to ensure we don't miss any messages
    final wsCompleter = Completer<void>();
    WebSocketChannel? channel;
    
    try {
      // Connect specifically with our Client ID so the server sends us the events
      channel = WebSocketChannel.connect(Uri.parse('$_wsUrl?clientId=$clientId'));
      
      // Temporary variable to store promptId once we get it
      String? targetPromptId;
      
      channel.stream.listen(
        (message) {
          if (targetPromptId == null) return; // Ignore messages until we know our ID
          
          try {
            final data = jsonDecode(message as String) as Map<String, dynamic>;
            final type = data['type'] as String?;
            final messageData = data['data'] as Map<String, dynamic>?;

            // Check if this message is for our prompt
            // Note: Some global messages might not have prompt_id, but execution/progress usually do
            final msgPromptId = messageData?['prompt_id'] as String?;
            
            // If message has specific prompt_id, verify it matches
            if (msgPromptId != null && msgPromptId != targetPromptId) return;

            if (type == 'progress') {
              final value = messageData?['value'] as int? ?? 0;
              final max = messageData?['max'] as int? ?? 100;
              _progressController?.add(ComfyUIProgress(
                type: ProgressType.generating,
                current: value,
                total: max,
              ));
            } else if (type == 'executing') {
              final nodeId = messageData?['node'] as String?;
              if (nodeId == null) {
                // Execution complete (node is null)
                if (!wsCompleter.isCompleted) {
                  wsCompleter.complete();
                }
              }
            } else if (type == 'execution_error') {
               if (!wsCompleter.isCompleted) {
                 wsCompleter.completeError(
                   ComfyUIException('Execution error: ${messageData}'),
                 );
               }
            }
          } catch (e) {
            print('Error parsing WS message: $e');
          }
        },
        onError: (error) {
          if (!wsCompleter.isCompleted) {
             // Don't fail immediately on WS error if we haven't started? 
             // But connection error is fatal.
             wsCompleter.completeError(error);
          }
        },
      );

      // Queue the prompt
      final body = jsonEncode({
        'prompt': workflow,
        'client_id': clientId,
      });
      
      print('----------------------------------------');
      print('🚀 Sending ComfyUI Request');
      print('URL: $_baseUrl/prompt');
      print('Payload: $body');
      print('----------------------------------------');

      final promptResponse = await _client.post(
        Uri.parse('$_baseUrl/prompt'),
        headers: {
          'Content-Type': 'application/json',
          ..._headers,
        },
        body: body,
      );

      print('Response Code: ${promptResponse.statusCode}');
      print('Response Body: ${promptResponse.body}');

      if (promptResponse.statusCode != 200) {
        throw ComfyUIException('Failed to queue prompt: ${promptResponse.statusCode}');
      }

      final promptJson = jsonDecode(promptResponse.body) as Map<String, dynamic>;
      targetPromptId = promptJson['prompt_id'] as String;

      // Wait for completion with timeout
      await wsCompleter.future.timeout(
        const Duration(seconds: 300),
        onTimeout: () {
          throw ComfyUIException('Image generation timed out');
        },
      );

      // Get the generated image
      final historyResponse = await _client.get(
        Uri.parse('$_baseUrl/history/$targetPromptId'),
        headers: _headers,
      );

      if (historyResponse.statusCode != 200) {
        throw ComfyUIException('Failed to get history: ${historyResponse.statusCode}');
      }

      final historyJson = jsonDecode(historyResponse.body) as Map<String, dynamic>;
      final outputs = historyJson[targetPromptId]?['outputs'] as Map<String, dynamic>?;

      if (outputs == null || outputs.isEmpty) {
        throw ComfyUIException('No outputs found');
      }

      // Find the image output node
      String? imageFilename;
      for (final output in outputs.values) {
        final images = (output as Map<String, dynamic>)['images'] as List?;
        if (images != null && images.isNotEmpty) {
          final firstImage = images.first as Map<String, dynamic>;
          imageFilename = firstImage['filename'] as String?;
          break;
        }
      }

      if (imageFilename == null) {
        throw ComfyUIException('No image found in outputs');
      }

      return GeneratedImageResult(
        filename: imageFilename,
        imageUrl: '$_baseUrl/view?filename=$imageFilename',
        promptId: targetPromptId,
      );
    } finally {
      await channel?.sink.close();
    }
  }

  /// 진행 상황 스트림
  Stream<ComfyUIProgress> get progressStream {
    _progressController ??= StreamController<ComfyUIProgress>.broadcast();
    return _progressController!.stream;
  }

  // _waitForCompletion removed as it is now inline

  /// 워크플로우 빌드
  Map<String, dynamic> _buildWorkflow({
    required String positivePrompt,
    required String negativePrompt,
    required ImageSize latentImageSize,
    required ComfyUIModelPreset modelPreset,
    required int seed,
  }) {
    final (width, height) = _getImageDimensions(latentImageSize);

    // Basic txt2img workflow
    return {
      '1': {
        'class_type': 'CheckpointLoaderSimple',
        'inputs': {
          'ckpt_name': modelPreset.checkpointModel,
        },
      },
      '2': {
        'class_type': 'CLIPTextEncode',
        'inputs': {
          'text': '${modelPreset.defaultPositive}, $positivePrompt',
          'clip': ['1', 1],
        },
      },
      '3': {
        'class_type': 'CLIPTextEncode',
        'inputs': {
          'text': '${modelPreset.defaultNegative}, $negativePrompt',
          'clip': ['1', 1],
        },
      },
      '4': {
        'class_type': 'EmptyLatentImage',
        'inputs': {
          'width': width,
          'height': height,
          'batch_size': 1,
        },
      },
      '5': {
        'class_type': 'KSampler',
        'inputs': {
          'seed': seed,
          'steps': modelPreset.steps,
          'cfg': modelPreset.cfgScale,
          'sampler_name': _mapSamplerName(modelPreset.sampler),
          'scheduler': modelPreset.scheduler.toLowerCase(),
          'denoise': 1.0,
          'model': ['1', 0],
          'positive': ['2', 0],
          'negative': ['3', 0],
          'latent_image': ['4', 0],
        },
      },
      '6': {
        'class_type': 'VAEDecode',
        'inputs': {
          'samples': ['5', 0],
          'vae': ['1', 2],
        },
      },
      '7': {
        'class_type': 'SaveImage',
        'inputs': {
          'filename_prefix': 'qualia',
          'images': ['6', 0],
        },
      },
    };
  }

  (int, int) _getImageDimensions(ImageSize size) {
    switch (size) {
      case ImageSize.portrait:
        return (832, 1216);
      case ImageSize.square:
        return (1024, 1024);
      case ImageSize.landscape:
        return (1216, 832);
    }
  }

  int _generateRandomSeed() {
    return DateTime.now().millisecondsSinceEpoch % 2147483647;
  }

  /// Map display sampler name to ComfyUI internal name
  String _mapSamplerName(String sampler) {
    final lower = sampler.toLowerCase().replaceAll('_', ' '); // Normalize
    
    // Euler variants
    if (lower == 'euler a' || lower == 'euler ancestral') return 'euler_ancestral';
    if (lower == 'euler') return 'euler';
    
    // DPM++ variants
    if (lower.contains('dpm++')) {
      // Handle "DPM++ 2M Karras" etc.
      String base = lower;
      if (base.contains('2m')) {
        if (base.contains('sde')) {
          return 'dpmpp_2m_sde';
        }
        return 'dpmpp_2m';
      }
      if (base.contains('sde')) return 'dpmpp_sde';
      if (base.contains('2s')) return 'dpmpp_2s_ancestral';
    }
    
    // Fallback: try basic snake_case conversion
    // e.g. "DPM++ 2M Karras" -> "dpm++_2m_karras" (invalid)
    // So we need to be careful.
    
    // If not matched above, basic sanitization
    var clean = sampler.toLowerCase();
    
    // Fix common replacements if not caught above
    clean = clean.replaceAll('dpm++', 'dpmpp');
    clean = clean.replaceAll(' ', '_');
    
    // Remove "karras" or "exponential" from sampler name if present (usually scheduler)
    // But some presets might have it in the string.
    // The scheduler is passed accurately in the 'scheduler' field usually.
    // But let's strip it just in case.
    clean = clean.replaceAll('_karras', '');
    clean = clean.replaceAll('_exponential', '');
    
    return clean;
  }

  void dispose() {
    _wsChannel?.sink.close();
    _progressController?.close();
    _client.close();
  }
}

/// System Stats
class SystemStats {
  final int vramTotal;
  final int vramFree;
  final int ramTotal;
  final int ramFree;

  SystemStats({
    required this.vramTotal,
    required this.vramFree,
    required this.ramTotal,
    required this.ramFree,
  });

  factory SystemStats.fromJson(Map<String, dynamic> json) {
    final devices = json['devices'] as List?;
    final firstDevice = devices?.firstOrNull as Map<String, dynamic>?;

    return SystemStats(
      vramTotal: firstDevice?['vram_total'] as int? ?? 0,
      vramFree: firstDevice?['vram_free'] as int? ?? 0,
      ramTotal: json['system']?['ram_total'] as int? ?? 0,
      ramFree: json['system']?['ram_free'] as int? ?? 0,
    );
  }
}

/// Generated Image Result
class GeneratedImageResult {
  final String filename;
  final String imageUrl;
  final String promptId;

  GeneratedImageResult({
    required this.filename,
    required this.imageUrl,
    required this.promptId,
  });
}

/// Progress info
class ComfyUIProgress {
  final ProgressType type;
  final int current;
  final int total;

  ComfyUIProgress({
    required this.type,
    required this.current,
    required this.total,
  });

  double get percentage => total > 0 ? current / total : 0;
}

enum ProgressType {
  queued,
  generating,
  complete,
}

/// ComfyUI Exception
class ComfyUIException implements Exception {
  final String message;

  ComfyUIException(this.message);

  @override
  String toString() => 'ComfyUIException: $message';
}
