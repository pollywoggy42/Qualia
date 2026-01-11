import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Settings View - App configuration
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  // ComfyUI Settings
  final _ipController = TextEditingController(text: '127.0.0.1');
  final _portController = TextEditingController(text: '8188');
  bool _comfyConnected = false;

  // OpenRouter Settings
  final _apiKeyController = TextEditingController();
  bool _openRouterAuthenticated = false;
  double? _creditBalance;

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ComfyUI Settings
          _buildSectionHeader('ComfyUI Settings'),
          _buildComfyUISection(),
          const SizedBox(height: 24),

          // OpenRouter Settings
          _buildSectionHeader('OpenRouter Settings'),
          _buildOpenRouterSection(),
          const SizedBox(height: 24),

          // Agent Settings
          _buildSectionHeader('Agent Settings'),
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

  Widget _buildComfyUISection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IP Address
            Text(
              'IP Address',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                hintText: '127.0.0.1',
              ),
            ),
            const SizedBox(height: 16),
            // Port
            Text(
              'Port',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '8188',
              ),
            ),
            const SizedBox(height: 16),
            // Test Connection
            Row(
              children: [
                ElevatedButton(
                  onPressed: _testComfyConnection,
                  child: const Text('Test Connection'),
                ),
                const SizedBox(width: 16),
                Icon(
                  _comfyConnected ? Icons.check_circle : Icons.cancel,
                  color: _comfyConnected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _comfyConnected ? 'Connected' : 'Disconnected',
                  style: TextStyle(
                    color: _comfyConnected ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenRouterSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // API Key
            Text(
              'API Key',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _apiKeyController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'sk-or-v1-...',
              ),
            ),
            const SizedBox(height: 16),
            // Verify & Sync
            Row(
              children: [
                ElevatedButton(
                  onPressed: _verifyOpenRouter,
                  child: const Text('Verify & Sync'),
                ),
                const SizedBox(width: 16),
                Icon(
                  _openRouterAuthenticated ? Icons.check_circle : Icons.cancel,
                  color: _openRouterAuthenticated ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _openRouterAuthenticated ? 'Authenticated' : 'Not Authenticated',
                  style: TextStyle(
                    color: _openRouterAuthenticated ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            if (_creditBalance != null) ...[
              const SizedBox(height: 12),
              Text(
                'Credit Balance: \$${_creditBalance!.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAgentSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgentSettingRow('Partner Agent', 'Grok 4.1 Fast', 0.7),
            const Divider(),
            _buildAgentSettingRow('Scenario Director', 'Grok 4.1 Fast', 0.8),
            const Divider(),
            _buildAgentSettingRow('Visual Director', 'Grok 4.1 Fast', 0.5),
            const Divider(),
            _buildAgentSettingRow('Strategist', 'Grok 4.1 Fast', 0.7),
            const Divider(),
            _buildAgentSettingRow('Scenario Generator', 'Grok 4.1 Fast', 0.9),
            const Divider(),
            _buildAgentSettingRow('SDXL Transformer', 'GPT-4o-mini', 0.3),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Reset to defaults
                  },
                  child: const Text('Reset to Defaults'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // Save settings
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentSettingRow(String name, String model, double temp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: model,
                  decoration: const InputDecoration(
                    labelText: 'Model',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    'Grok 4.1 Fast',
                    'GPT-4o',
                    'GPT-4o-mini',
                    'Claude 3.5 Sonnet',
                  ].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                  onChanged: (v) {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: temp.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Temp',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _testComfyConnection() async {
    // TODO: Implement ComfyUI connection test
    setState(() => _comfyConnected = true);
  }

  Future<void> _verifyOpenRouter() async {
    // TODO: Implement OpenRouter verification
    setState(() {
      _openRouterAuthenticated = true;
      _creditBalance = 12.45;
    });
  }
}
