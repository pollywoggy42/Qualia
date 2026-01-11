import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/openrouter_service.dart';
import 'storage_provider.dart';

part 'openrouter_provider.g.dart';

/// OpenRouter Service Provider
@riverpod
OpenRouterService? openRouterService(OpenRouterServiceRef ref) {
  final storage = ref.watch(storageServiceProvider);
  final apiKey = storage.getOpenRouterApiKey();

  if (apiKey == null || apiKey.isEmpty) {
    return null;
  }

  return OpenRouterService(apiKey: apiKey);
}

/// OpenRouter 인증 상태
@riverpod
class OpenRouterAuth extends _$OpenRouterAuth {
  @override
  Future<AccountInfo?> build() async {
    final service = ref.watch(openRouterServiceProvider);
    if (service == null) return null;

    try {
      return await service.verifyApiKey();
    } catch (e) {
      return null;
    }
  }

  Future<bool> setApiKey(String apiKey) async {
    final storage = ref.read(storageServiceProvider);
    await storage.setOpenRouterApiKey(apiKey);

    // Verify the key
    ref.invalidateSelf();
    final result = await future;
    return result != null;
  }
}

/// 사용 가능한 모델 목록
@riverpod
Future<List<ModelInfo>> availableModels(AvailableModelsRef ref) async {
  final service = ref.watch(openRouterServiceProvider);
  if (service == null) return [];

  try {
    return await service.getModels();
  } catch (e) {
    return [];
  }
}
