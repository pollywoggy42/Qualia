import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/storage_service.dart';
import 'storage_provider.dart';

part 'settings_provider.g.dart';

/// 테마 모드 Provider
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final storage = ref.watch(storageServiceProvider);
    final mode = storage.getThemeMode();

    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final storage = ref.read(storageServiceProvider);
    final modeString = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await storage.setThemeMode(modeString);
    ref.invalidateSelf();
  }
}

/// Agent 설정 Provider
@riverpod
class AgentSettingsNotifier extends _$AgentSettingsNotifier {
  @override
  AgentSettings build(String agentName) {
    final storage = ref.watch(storageServiceProvider);
    return storage.getAgentSettings(agentName);
  }

  Future<void> updateSettings(AgentSettings settings) async {
    final storage = ref.read(storageServiceProvider);
    // agentName is the first argument passed to build()
    final name = (this as dynamic).agentName as String;
    await storage.setAgentSettings(name, settings);
    ref.invalidateSelf();
  }
}

/// 모든 Agent 설정
@riverpod
Map<String, AgentSettings> allAgentSettings(AllAgentSettingsRef ref) {
  const agentNames = [
    'partner',
    'scenario_director',
    'visual_director',
    'strategist',
    'scenario_generator',
    'sdxl_transformer',
  ];

  final settings = <String, AgentSettings>{};
  for (final name in agentNames) {
    settings[name] = ref.watch(agentSettingsNotifierProvider(name));
  }

  return settings;
}
