import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/settings_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/openrouter_provider.dart';
import '../../providers/comfyui_provider.dart';
import '../../providers/storage_provider.dart';
import '../../widgets/glass_card.dart';

/// Settings View - App configuration
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  // ComfyUI Settings
  late TextEditingController _ipController;
  late TextEditingController _portController;

  // OpenRouter Settings
  late TextEditingController _apiKeyController;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController();
    _portController = TextEditingController();
    _apiKeyController = TextEditingController();
  }

  void _initializeControllers() {
    if (_initialized) return;

    // Storage 초기화 확인
    final storageInit = ref.read(storageInitializedProvider);
    if (!storageInit.hasValue) return;

    final storage = ref.read(storageServiceProvider);
    _ipController.text = storage.getComfyUIHost();
    _portController.text = storage.getComfyUIPort().toString();

    final apiKey = storage.getOpenRouterApiKey();
    if (apiKey != null) {
      _apiKeyController.text = apiKey;
    }

    _initialized = true;
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Storage 초기화 대기
    final storageInit = ref.watch(storageInitializedProvider);

    _initializeControllers();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Watch providers for reactive updates (triggers rebuild on state change)
    ref.watch(comfyUIConnectionProvider);
    ref.watch(openRouterAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Settings
          _buildSectionHeader(l10n.appearance),
          _buildAppearanceSection(isDark, l10n),
          const SizedBox(height: 24),

          // Language Settings
          _buildSectionHeader(l10n.language),
          _buildLanguageSection(l10n),
          const SizedBox(height: 24),

          // ComfyUI Settings
          _buildSectionHeader(l10n.comfyUI),
          _buildComfyUISection(l10n),
          const SizedBox(height: 24),

          // OpenRouter Settings
          _buildSectionHeader(l10n.openRouter),
          _buildOpenRouterSection(l10n),
          const SizedBox(height: 24),

          // Agent Settings
          _buildSectionHeader(l10n.agentSettings),
          _buildAgentSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildAppearanceSection(bool isDark, AppLocalizations l10n) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    print('🎨 [SETTINGS] Building appearance section - Current theme mode: $themeMode, isDark: $isDark');

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.theme,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.themeDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildThemeOption(
                icon: Icons.light_mode,
                label: l10n.themeLight,
                isSelected: themeMode == ThemeMode.light,
                onTap: () {
                  print('💡 [SETTINGS] Light theme button TAPPED - Current: $themeMode');
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                  print('💡 [SETTINGS] Light theme setThemeMode called');
                },
              ),
              const SizedBox(width: 12),
              _buildThemeOption(
                icon: Icons.dark_mode,
                label: l10n.themeDark,
                isSelected: themeMode == ThemeMode.dark,
                onTap: () {
                  print('🌙 [SETTINGS] Dark theme button TAPPED - Current: $themeMode');
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                  print('🌙 [SETTINGS] Dark theme setThemeMode called');
                },
              ),
              const SizedBox(width: 12),
              _buildThemeOption(
                icon: Icons.settings_suggest,
                label: l10n.themeSystem,
                isSelected: themeMode == ThemeMode.system,
                onTap: () {
                  print('⚙️ [SETTINGS] System theme button TAPPED - Current: $themeMode');
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.system);
                  print('⚙️ [SETTINGS] System theme setThemeMode called');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(AppLocalizations l10n) {
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    final currentLocale = ref.watch(localeNotifierProvider);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.language,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.languageDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLanguageOption(
                label: 'English',
                locale: const Locale('en'),
                isSelected: currentLocale?.languageCode == 'en',
                onTap: () => localeNotifier.setLocale(const Locale('en')),
              ),
              const SizedBox(width: 12),
              _buildLanguageOption(
                label: '한국어',
                locale: const Locale('ko'),
                isSelected: currentLocale?.languageCode == 'ko',
                onTap: () => localeNotifier.setLocale(const Locale('ko')),
              ),
              const SizedBox(width: 12),
              _buildLanguageOption(
                label: 'System',
                locale: null,
                isSelected: currentLocale == null,
                onTap: () => localeNotifier.setLocale(null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required String label,
    required Locale? locale,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(30)
                : (isDark ? Colors.grey[850] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.language,
                size: 24,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    print('🔨 [SETTINGS] Building theme option: $label, isSelected: $isSelected');

    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('👆 [SETTINGS] GestureDetector tapped for: $label');
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(30)
                : (isDark ? Colors.grey[850] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComfyUISection(AppLocalizations l10n) {
    final comfyConnection = ref.watch(comfyUIConnectionProvider);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingField(
            label: l10n.ipAddress,
            hint: l10n.ipAddressHint,
            child: TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                hintText: '127.0.0.1',
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingField(
            label: l10n.port,
            hint: l10n.portHint,
            child: TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '8188',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GlassButton(
                label: l10n.testConnection,
                icon: Icons.wifi_tethering,
                onPressed: _testComfyConnection,
              ),
              const SizedBox(width: 16),
              comfyConnection.when(
                data: (isConnected) => Row(
                  children: [
                    Icon(
                      isConnected ? Icons.check_circle : Icons.cancel,
                      color: isConnected ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isConnected ? l10n.connected : l10n.disconnected,
                      style: TextStyle(
                        fontSize: 13,
                        color: isConnected ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Error', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpenRouterSection(AppLocalizations l10n) {
    final openRouterAuth = ref.watch(openRouterAuthProvider);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingField(
            label: l10n.apiKey,
            hint: l10n.apiKeyHint,
            child: TextField(
              controller: _apiKeyController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'sk-or-v1-...',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GlassButton(
                label: l10n.verifySync,
                icon: Icons.verified_user,
                onPressed: _verifyOpenRouter,
              ),
              const SizedBox(width: 16),
              openRouterAuth.when(
                data: (accountInfo) => Row(
                  children: [
                    Icon(
                      accountInfo != null ? Icons.check_circle : Icons.cancel,
                      color: accountInfo != null ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      accountInfo != null ? l10n.authenticated : l10n.notConnected,
                      style: TextStyle(
                        fontSize: 13,
                        color: accountInfo != null ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Error', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          openRouterAuth.maybeWhen(
            data: (accountInfo) {
              if (accountInfo != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GlassChip(
                    label: '\$${accountInfo.creditBalance.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet,
                    color: Colors.green,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingField({
    required String label,
    required String hint,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          hint,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildAgentSettingsSection() {
    return Column(
      children: [
        _buildAgentCard(
          name: 'Partner Agent',
          description: 'Generates partner dialogue, actions, and emotional responses',
          defaultModel: 'x-ai/grok-3-fast',
          defaultTemp: 0.7,
        ),
        _buildAgentCard(
          name: 'Scenario Director',
          description: 'Manages narrative flow and world state changes',
          defaultModel: 'x-ai/grok-3-fast',
          defaultTemp: 0.8,
        ),
        _buildAgentCard(
          name: 'Visual Director',
          description: 'Creates image prompts from scene context',
          defaultModel: 'x-ai/grok-3-fast',
          defaultTemp: 0.5,
        ),
        _buildAgentCard(
          name: 'Strategist',
          description: 'Generates player choice options with success rates',
          defaultModel: 'x-ai/grok-3-fast',
          defaultTemp: 0.7,
        ),
        _buildAgentCard(
          name: 'Scenario Generator',
          description: 'Creates initial scenarios and partner profiles',
          defaultModel: 'x-ai/grok-3-fast',
          defaultTemp: 0.9,
        ),
        _buildAgentCard(
          name: 'SDXL Transformer',
          description: 'Converts natural language to SDXL prompt tags',
          defaultModel: 'openai/gpt-4o-mini',
          defaultTemp: 0.3,
        ),
      ],
    );
  }

  Widget _buildAgentCard({
    required String name,
    required String description,
    required String defaultModel,
    required double defaultTemp,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.smart_toy,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Model Selection
            _buildAgentSetting(
              label: 'Model',
              hint: 'LLM model for this agent',
              child: DropdownButtonFormField<String>(
                value: defaultModel,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'x-ai/grok-3-fast',
                    child: Text('Grok 3 Fast'),
                  ),
                  DropdownMenuItem(
                    value: 'openai/gpt-4o',
                    child: Text('GPT-4o'),
                  ),
                  DropdownMenuItem(
                    value: 'openai/gpt-4o-mini',
                    child: Text('GPT-4o Mini'),
                  ),
                  DropdownMenuItem(
                    value: 'anthropic/claude-3.5-sonnet',
                    child: Text('Claude 3.5 Sonnet'),
                  ),
                ],
                onChanged: (v) {},
              ),
            ),
            const SizedBox(height: 12),

            // Temperature
            _buildAgentSetting(
              label: 'Temperature',
              hint: 'Creativity level (0 = deterministic, 1 = creative)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: defaultTemp,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: defaultTemp.toStringAsFixed(1),
                      onChanged: (v) {},
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      defaultTemp.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Max Tokens
            _buildAgentSetting(
              label: 'Max Tokens',
              hint: 'Maximum response length',
              child: TextFormField(
                initialValue: '2048',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Top P
            _buildAgentSetting(
              label: 'Top P',
              hint: 'Nucleus sampling (0.1 = focused, 1.0 = diverse)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: 0.9,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: '0.9',
                      onChanged: (v) {},
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '0.9',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Frequency Penalty
            _buildAgentSetting(
              label: 'Frequency Penalty',
              hint: 'Reduce repetition of tokens (-2.0 to 2.0)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: 0.0,
                      min: -2.0,
                      max: 2.0,
                      divisions: 40,
                      label: '0.0',
                      onChanged: (v) {},
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '0.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Presence Penalty
            _buildAgentSetting(
              label: 'Presence Penalty',
              hint: 'Encourage new topics (-2.0 to 2.0)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: 0.0,
                      min: -2.0,
                      max: 2.0,
                      divisions: 40,
                      label: '0.0',
                      onChanged: (v) {},
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '0.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildAgentSetting({
    required String label,
    required String hint,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          hint,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontSize: 11,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Future<void> _testComfyConnection() async {
    // Update settings first
    await ref.read(comfyUIConnectionProvider.notifier).updateSettings(
      host: _ipController.text,
      port: int.tryParse(_portController.text) ?? 8188,
    );

    // Test connection
    await ref.read(comfyUIConnectionProvider.notifier).testConnection();
  }

  Future<void> _verifyOpenRouter() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isEmpty) return;

    // Save and verify the API key
    await ref.read(openRouterAuthProvider.notifier).setApiKey(apiKey);
  }
}
