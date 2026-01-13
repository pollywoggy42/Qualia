import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/agents/strategist_agent.dart';
import 'openrouter_provider.dart';
import 'storage_provider.dart';

part 'strategist_agent_provider.g.dart';

/// Strategist Agent Provider
@riverpod
StrategistAgent? strategistAgent(StrategistAgentRef ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  if (openRouterService == null) return null;

  final storage = ref.watch(storageServiceProvider);
  final settings = storage.getAgentSettings('strategist');

  return StrategistAgent(
    openRouterService: openRouterService,
    settings: settings,
  );
}
