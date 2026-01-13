import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/agents/input_interpreter_agent.dart';
import 'openrouter_provider.dart';
import 'storage_provider.dart';

part 'input_interpreter_provider.g.dart';

/// Input Interpreter Agent Provider
@riverpod
InputInterpreterAgent? inputInterpreterAgent(InputInterpreterAgentRef ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  if (openRouterService == null) return null;

  final storage = ref.watch(storageServiceProvider);
  // Reuse strategist settings as it is a similar reasoning task, or default
  final settings = storage.getAgentSettings('strategist'); 

  return InputInterpreterAgent(
    openRouterService: openRouterService,
    settings: settings,
  );
}
