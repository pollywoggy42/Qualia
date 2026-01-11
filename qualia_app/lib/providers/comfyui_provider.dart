import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/comfyui_service.dart';
import '../models/comfyui_model_preset.dart';
import 'storage_provider.dart';

part 'comfyui_provider.g.dart';

/// ComfyUI Service Provider
@riverpod
ComfyUIService comfyUIService(ComfyUIServiceRef ref) {
  final storage = ref.watch(storageServiceProvider);

  return ComfyUIService(
    host: storage.getComfyUIHost(),
    port: storage.getComfyUIPort(),
  );
}

/// ComfyUI 연결 상태
@riverpod
class ComfyUIConnection extends _$ComfyUIConnection {
  @override
  Future<bool> build() async {
    final service = ref.watch(comfyUIServiceProvider);
    return await service.testConnection();
  }

  Future<bool> testConnection() async {
    final service = ref.read(comfyUIServiceProvider);
    final result = await service.testConnection();
    ref.invalidateSelf();
    return result;
  }

  Future<void> updateSettings({
    required String host,
    required int port,
  }) async {
    final storage = ref.read(storageServiceProvider);
    await storage.setComfyUISettings(host: host, port: port);
    ref.invalidateSelf();
  }
}

/// ComfyUI 시스템 정보
@riverpod
Future<SystemStats?> comfyUISystemStats(ComfyUISystemStatsRef ref) async {
  final isConnected = await ref.watch(comfyUIConnectionProvider.future);
  if (!isConnected) return null;

  final service = ref.watch(comfyUIServiceProvider);
  try {
    return await service.getSystemStats();
  } catch (e) {
    return null;
  }
}

/// 모델 프리셋 목록
@riverpod
class ModelPresets extends _$ModelPresets {
  @override
  List<ComfyUIModelPreset> build() {
    final storage = ref.watch(storageServiceProvider);
    return storage.getAllPresets();
  }

  Future<void> addPreset(ComfyUIModelPreset preset) async {
    final storage = ref.read(storageServiceProvider);
    await storage.savePreset(preset);
    ref.invalidateSelf();
  }

  Future<void> deletePreset(String id) async {
    final storage = ref.read(storageServiceProvider);
    await storage.deletePreset(id);
    ref.invalidateSelf();
  }
}
