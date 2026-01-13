import 'dart:async';
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
  Future<ComfyUIConnectionState> build() async {
    final service = ref.watch(comfyUIServiceProvider);
    try {
      final isConnected = await service.testConnection();
      return ComfyUIConnectionState(
        isConnected: isConnected,
        errorMessage: isConnected ? null : 'Could not connect to ComfyUI server',
      );
    } catch (e) {
      return ComfyUIConnectionState(
        isConnected: false,
        errorMessage: 'Error: $e',
      );
    }
  }

  Future<ComfyUIConnectionState> testConnection() async {
    final service = ref.read(comfyUIServiceProvider);
    try {
      final result = await service.testConnection();
      final newState = ComfyUIConnectionState(
        isConnected: result,
        errorMessage: result ? null : 'Connection test failed - verify host and port',
      );
      state = AsyncValue.data(newState);
      return newState;
    } on TimeoutException {
      final newState = ComfyUIConnectionState(
        isConnected: false,
        errorMessage: 'Connection timeout - server took too long to respond. Check if server is running and reachable.',
      );
      state = AsyncValue.data(newState);
      return newState;
    } catch (e) {
      String errorMsg = 'Connection error: $e';
      
      // Check for common error types
      if (e.toString().contains('XMLHttpRequest') || 
          e.toString().contains('ClientException') || 
          e.toString().contains('Failed to fetch')) {
        errorMsg = 'CORS error - ComfyUI server must allow web access. Add --enable-cors-header flag when starting ComfyUI.';
      } else if (e.toString().contains('Failed host lookup')) {
        errorMsg = 'Network error - cannot resolve hostname. Check IP address.';
      } else if (e.toString().contains('Connection refused')) {
        errorMsg = 'Connection refused - server may not be running or firewall blocking access.';
      }
      
      final newState = ComfyUIConnectionState(
        isConnected: false,
        errorMessage: errorMsg,
      );
      state = AsyncValue.data(newState);
      return newState;
    }
  }

  Future<void> updateSettings({
    required String host,
    required int port,
  }) async {
    final storage = ref.read(storageServiceProvider);
    await storage.setComfyUISettings(host: host, port: port);
    
    // Invalidate both the service and connection providers
    ref.invalidate(comfyUIServiceProvider);
    ref.invalidateSelf();
  }
}

/// ComfyUI 연결 상태 모델
class ComfyUIConnectionState {
  final bool isConnected;
  final String? errorMessage;

  ComfyUIConnectionState({
    required this.isConnected,
    this.errorMessage,
  });
}


/// ComfyUI 시스템 정보
@riverpod
Future<SystemStats?> comfyUISystemStats(ComfyUISystemStatsRef ref) async {
  final connectionState = await ref.watch(comfyUIConnectionProvider.future);
  if (!connectionState.isConnected) return null;

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
