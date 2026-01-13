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

    ref.invalidate(openRouterServiceProvider);
    ref.invalidateSelf();

    try {
      final result = await future;
      return result != null;
    } catch (e) {
      return false;
    }
  }
}

/// 사용 가능한 모델 목록
@riverpod
Future<List<ModelInfo>> availableModels(AvailableModelsRef ref) async {
  final service = ref.watch(openRouterServiceProvider);
  if (service == null) return [];

  try {
    final models = await service.getModels();
    // Sort by name alphabetically
    models.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return models;
  } catch (e) {
    return [];
  }
}

/// 크레딧 잔액 정보
@riverpod
class OpenRouterCredits extends _$OpenRouterCredits {
  @override
  Future<CreditBalance?> build() async {
    final service = ref.watch(openRouterServiceProvider);
    if (service == null) return null;

    try {
      return await service.getCreditBalance();
    } catch (e) {
      return null;
    }
  }

  /// 크레딧 정보 새로고침
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
