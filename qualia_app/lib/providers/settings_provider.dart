import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/storage_service.dart';
import 'storage_provider.dart';

part 'settings_provider.g.dart';

/// 테마 모드 Notifier - 테마 모드 설정 관리
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.system; // Default to system
  }

  Future<void> _loadThemeMode() async {
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.initialize();
      final mode = storage.getThemeMode();
      print('🔧 [PROVIDER] Loading theme mode: $mode');
      
      state = switch (mode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
      print('🔧 [PROVIDER] Theme mode set to: $state');
    } catch (e) {
      print('❌ [PROVIDER] Error loading theme mode: $e');
      // Keep default on error
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    print('🔄 [PROVIDER] setThemeMode() called with: $mode');
    
    // Update state immediately for UI
    state = mode;
    print('✅ [PROVIDER] State updated to: $state');
    
    // Persist to storage
    try {
      final storage = ref.read(storageServiceProvider);
      final modeString = switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
      print('🔄 [PROVIDER] Saving to storage: $modeString');
      await storage.setThemeMode(modeString);
      print('✅ [PROVIDER] Theme mode saved successfully');
    } catch (e) {
      print('❌ [PROVIDER] Error saving theme mode: $e');
    }
  }
}

/// 테마 모드 Provider
final themeModeNotifierProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

/// Agent 설정 Provider
@riverpod
class AgentSettingsNotifier extends _$AgentSettingsNotifier {
  @override
  AgentSettings build(String agentName) {
    // Storage가 초기화될 때까지 기다림
    final initialized = ref.watch(storageInitializedProvider);

    return initialized.when(
      data: (_) {
        final storage = ref.watch(storageServiceProvider);
        return storage.getAgentSettings(agentName);
      },
      loading: () => AgentSettings.defaultFor(agentName),
      error: (_, __) => AgentSettings.defaultFor(agentName),
    );
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
