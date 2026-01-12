import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/agents/scenario_generator.dart';
import 'openrouter_provider.dart';
import 'storage_provider.dart';

part 'scenario_generator_provider.g.dart';

/// ScenarioGenerator Agent Provider
@riverpod
ScenarioGeneratorAgent? scenarioGeneratorAgent(ScenarioGeneratorAgentRef ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  if (openRouterService == null) return null;

  final storage = ref.watch(storageServiceProvider);
  final settings = storage.getAgentSettings('scenario_generator');

  return ScenarioGeneratorAgent(
    openRouterService: openRouterService,
    settings: settings,
  );
}

/// 시나리오 생성 상태
@riverpod
class ScenarioGeneration extends _$ScenarioGeneration {
  @override
  AsyncValue<ScenarioGenerationResult?> build() {
    return const AsyncValue.data(null);
  }

  /// 시나리오 생성 시작
  Future<ScenarioGenerationResult?> generate({
    required String userGender,
    required String partnerGender,
    String? theme,
    String? setting,
  }) async {
    state = const AsyncValue.loading();

    try {
      final agent = ref.read(scenarioGeneratorAgentProvider);
      if (agent == null) {
        throw Exception('OpenRouter API key not configured');
      }

      final result = await agent.generate(
        userGender: userGender,
        partnerGender: partnerGender,
        theme: theme,
        setting: setting,
      );

      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// 상태 초기화
  void reset() {
    state = const AsyncValue.data(null);
  }
}
