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
import '../../services/openrouter_service.dart';

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
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                },
              ),
              const SizedBox(width: 12),
              _buildThemeOption(
                icon: Icons.dark_mode,
                label: l10n.themeDark,
                isSelected: themeMode == ThemeMode.dark,
                onTap: () {
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                },
              ),
              const SizedBox(width: 12),
              _buildThemeOption(
                icon: Icons.settings_suggest,
                label: l10n.themeSystem,
                isSelected: themeMode == ThemeMode.system,
                onTap: () {
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(ThemeMode.system);
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withAlpha(50)
                : (isDark ? Colors.grey[850] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : (isDark ? Colors.white.withAlpha(20) : Colors.grey.withAlpha(50)),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withAlpha(40),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 150),
                scale: isSelected ? 1.1 : 1.0,
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? primaryColor : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryColor : null,
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
                data: (state) => Row(
                  children: [
                    Icon(
                      state.isConnected ? Icons.check_circle : Icons.cancel,
                      color: state.isConnected ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.isConnected ? l10n.connected : l10n.disconnected,
                      style: TextStyle(
                        fontSize: 13,
                        color: state.isConnected ? Colors.green : Colors.red,
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
          // Show error message if connection failed
          comfyConnection.maybeWhen(
            data: (state) {
              if (!state.isConnected && state.errorMessage != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
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

  Widget _buildOpenRouterSection(AppLocalizations l10n) {
    final openRouterAuth = ref.watch(openRouterAuthProvider);
    final credits = ref.watch(openRouterCreditsProvider);

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
          // Credit balance display
          openRouterAuth.maybeWhen(
            data: (accountInfo) {
              if (accountInfo != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Credit Balance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    credits.when(
                      data: (creditBalance) {
                        if (creditBalance != null) {
                          final usedPercentage = creditBalance.totalGranted > 0
                              ? (creditBalance.totalUsed / creditBalance.totalGranted * 100)
                              : 0.0;

                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                // Remaining (bold, green)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Remaining',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '\$${creditBalance.totalRemaining.toStringAsFixed(4)}',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Total
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '\$${creditBalance.totalGranted.toStringAsFixed(4)}',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Used
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Used',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${usedPercentage.toStringAsFixed(1)}%',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                                const Divider(height: 32),
                                // Refresh button
                                GestureDetector(
                                  onTap: () => ref.read(openRouterCreditsProvider.notifier).refresh(),
                                  child: Text(
                                    'Refresh Balance',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => const Text(
                        'Failed to load credit info',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
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
    final openRouterAuth = ref.watch(openRouterAuthProvider);
    final availableModels = ref.watch(availableModelsProvider);

    // Only show if authenticated
    return openRouterAuth.maybeWhen(
      data: (accountInfo) {
        if (accountInfo == null) {
          return GlassCard(
            child: Column(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'OpenRouter Authentication Required',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please verify your OpenRouter API key to configure agent settings',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        // Authenticated - show agent cards
        return Column(
          children: [
            _buildAgentCard(
              agentKey: 'partner',
              name: 'Partner Agent',
              description: 'Generates partner dialogue, actions, and emotional responses',
              availableModels: availableModels,
            ),
            _buildAgentCard(
              agentKey: 'scenario_director',
              name: 'Scenario Director',
              description: 'Manages narrative flow and world state changes',
              availableModels: availableModels,
            ),
            _buildAgentCard(
              agentKey: 'visual_director',
              name: 'Visual Director',
              description: 'Creates image prompts from scene context',
              availableModels: availableModels,
            ),
            _buildAgentCard(
              agentKey: 'strategist',
              name: 'Strategist',
              description: 'Generates player choice options with success rates',
              availableModels: availableModels,
            ),
            _buildAgentCard(
              agentKey: 'scenario_generator',
              name: 'Scenario Generator',
              description: 'Creates initial scenarios and partner profiles',
              availableModels: availableModels,
            ),
            _buildAgentCard(
              agentKey: 'sdxl_transformer',
              name: 'SDXL Transformer',
              description: 'Converts natural language to SDXL prompt tags',
              availableModels: availableModels,
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildAgentCard({
    required String agentKey,
    required String name,
    required String description,
    required AsyncValue<List<ModelInfo>> availableModels,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final agentSettings = ref.watch(agentSettingsNotifierProvider(agentKey));

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
            _buildSettingField(
              label: 'Model',
              hint: 'LLM model for this agent',
              child: availableModels.when(
                data: (models) {
                  // If no models are available, show a fallback
                  if (models.isEmpty) {
                    return const Text(
                      'Loading models...',
                      style: TextStyle(color: Colors.grey),
                    );
                  }

                  // Ensure the current model exists in the list
                  final currentModel = agentSettings.model;
                  final modelExists = models.any((m) => m.id == currentModel);

                  final effectiveModels = [...models];
                  if (!modelExists) {
                    effectiveModels.add(ModelInfo(
                      id: currentModel,
                      name: currentModel,
                      promptPricing: 0,
                      completionPricing: 0,
                      contextLength: 0,
                    ));
                  }

                  return DropdownButtonFormField<String>(
                    value: currentModel,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: effectiveModels.map((model) {
                      return DropdownMenuItem(
                        value: model.id,
                        child: Text(
                          model.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(agentSettingsNotifierProvider(agentKey).notifier).setModel(value);
                      }
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('Error loading models'),
              ),
            ),
            const SizedBox(height: 12),

            // Temperature
            _buildSettingField(
              label: 'Temperature',
              hint: 'Creativity level (0 = deterministic, 1 = creative)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: agentSettings.temperature,
                      min: 0,
                      max: 2.0,
                      divisions: 20,
                      label: agentSettings.temperature.toStringAsFixed(1),
                      onChanged: (value) {
                         ref.read(agentSettingsNotifierProvider(agentKey).notifier).setTemperature(value);
                      },
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
                      agentSettings.temperature.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Max Tokens
            _buildSettingField(
              label: 'Max Tokens',
              hint: 'Maximum response length',
              child: TextFormField(
                initialValue: agentSettings.maxTokens.toString(),
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
                onChanged: (value) {
                  final tokens = int.tryParse(value);
                  if (tokens != null) {
                    ref.read(agentSettingsNotifierProvider(agentKey).notifier).setMaxTokens(tokens);
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            // Top P
            _buildSettingField(
              label: 'Top P',
              hint: 'Nucleus sampling (0.1 = focused, 1.0 = diverse)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: agentSettings.topP ?? 1.0,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: (agentSettings.topP ?? 1.0).toStringAsFixed(1),
                      onChanged: (value) {
                        ref.read(agentSettingsNotifierProvider(agentKey).notifier).setTopP(value);
                      },
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
                      (agentSettings.topP ?? 1.0).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Frequency Penalty
            _buildSettingField(
              label: 'Frequency Penalty',
              hint: 'Reduce repetition of tokens (-2.0 to 2.0)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: agentSettings.frequencyPenalty ?? 0.0,
                      min: -2.0,
                      max: 2.0,
                      divisions: 40,
                      label: (agentSettings.frequencyPenalty ?? 0.0).toStringAsFixed(1),
                      onChanged: (value) {
                        ref.read(agentSettingsNotifierProvider(agentKey).notifier).setFrequencyPenalty(value);
                      },
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
                      (agentSettings.frequencyPenalty ?? 0.0).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Presence Penalty
            _buildSettingField(
              label: 'Presence Penalty',
              hint: 'Encourage new topics (-2.0 to 2.0)',
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: agentSettings.presencePenalty ?? 0.0,
                      min: -2.0,
                      max: 2.0,
                      divisions: 40,
                      label: (agentSettings.presencePenalty ?? 0.0).toStringAsFixed(1),
                      onChanged: (value) {
                        ref.read(agentSettingsNotifierProvider(agentKey).notifier).setPresencePenalty(value);
                      },
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
                      (agentSettings.presencePenalty ?? 0.0).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Future<void> _testComfyConnection() async {
    // Update settings first
    await ref.read(comfyUIConnectionProvider.notifier).updateSettings(
      host: _ipController.text,
      port: int.tryParse(_portController.text) ?? 8188,
    );

    // Wait a bit for the provider to rebuild with new settings
    await Future.delayed(const Duration(milliseconds: 100));

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
