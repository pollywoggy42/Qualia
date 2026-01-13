import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/agents/partner_agent.dart';
import 'openrouter_provider.dart';
import 'storage_provider.dart';

part 'partner_agent_provider.g.dart';

/// Partner Agent Provider
@riverpod
PartnerAgent? partnerAgent(PartnerAgentRef ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  if (openRouterService == null) return null;

  final storage = ref.watch(storageServiceProvider);
  final settings = storage.getAgentSettings('partner');

  return PartnerAgent(
    openRouterService: openRouterService,
    settings: settings,
  );
}
