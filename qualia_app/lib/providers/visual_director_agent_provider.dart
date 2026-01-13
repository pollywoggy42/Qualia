import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/agents/visual_director_agent.dart';
import 'openrouter_provider.dart';
import 'storage_provider.dart';

part 'visual_director_agent_provider.g.dart';

/// Visual Director Agent Provider
@riverpod
VisualDirectorAgent? visualDirectorAgent(VisualDirectorAgentRef ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  if (openRouterService == null) return null;

  final storage = ref.watch(storageServiceProvider);
  final settings = storage.getAgentSettings('visual_director');

  return VisualDirectorAgent(
    openRouterService: openRouterService,
    settings: settings,
  );
}
