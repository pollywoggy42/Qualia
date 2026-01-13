import 'dart:convert';
import 'dart:async';
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

  String get _baseUrl => 'http://$_host:$_port';
  String get _wsUrl => 'ws://$_host:$_port/ws';

  /// 연결 테스트
  Future<bool> testConnection() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/system_stats'),
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
      return false;
    }
  }

  /// 시스템 정보 조회
  Future<SystemStats> getSystemStats() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/system_stats'),
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

    // Queue the prompt
    final promptResponse = await _client.post(
      Uri.parse('$_baseUrl/prompt'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'prompt': workflow,
        'client_id': clientId,
      }),
    );

    if (promptResponse.statusCode != 200) {
      throw ComfyUIException('Failed to queue prompt: ${promptResponse.statusCode}');
    }

    final promptJson = jsonDecode(promptResponse.body) as Map<String, dynamic>;
    final promptId = promptJson['prompt_id'] as String;

    // Wait for completion
    await _waitForCompletion(promptId);

    // Get the generated image
    final historyResponse = await _client.get(
      Uri.parse('$_baseUrl/history/$promptId'),
    );

    if (historyResponse.statusCode != 200) {
      throw ComfyUIException('Failed to get history: ${historyResponse.statusCode}');
    }

    final historyJson = jsonDecode(historyResponse.body) as Map<String, dynamic>;
    final outputs = historyJson[promptId]?['outputs'] as Map<String, dynamic>?;

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
      promptId: promptId,
    );
  }

  /// 진행 상황 스트림
  Stream<ComfyUIProgress> get progressStream {
    _progressController ??= StreamController<ComfyUIProgress>.broadcast();
    return _progressController!.stream;
  }

  /// WebSocket 연결로 진행 상황 모니터링
  Future<void> _waitForCompletion(String promptId) async {
    final completer = Completer<void>();

    try {
      _wsChannel = WebSocketChannel.connect(Uri.parse(_wsUrl));

      _wsChannel!.stream.listen(
        (message) {
          final data = jsonDecode(message as String) as Map<String, dynamic>;
          final type = data['type'] as String?;

          if (type == 'progress') {
            final value = data['data']?['value'] as int? ?? 0;
            final max = data['data']?['max'] as int? ?? 100;
            _progressController?.add(ComfyUIProgress(
              type: ProgressType.generating,
              current: value,
              total: max,
            ));
          } else if (type == 'executing') {
            final nodeId = data['data']?['node'] as String?;
            if (nodeId == null) {
              // Execution complete
              if (!completer.isCompleted) {
                completer.complete();
              }
            }
          } else if (type == 'execution_error') {
            if (!completer.isCompleted) {
              completer.completeError(
                ComfyUIException('Execution error: ${data['data']}'),
              );
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
      );

      // Timeout after 60 seconds
      await completer.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw ComfyUIException('Image generation timed out');
        },
      );
    } finally {
      await _wsChannel?.sink.close();
      _wsChannel = null;
    }
  }

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
          'sampler_name': modelPreset.sampler.toLowerCase().replaceAll(' ', '_'),
          'scheduler': modelPreset.scheduler,
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
