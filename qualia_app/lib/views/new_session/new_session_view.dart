import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/comfyui_model_preset.dart';
import 'widgets/preset_editor.dart';

/// New Session View - Session creation flow
/// Step 0: Select Preset
/// Step 1: Customize Preset
/// Step 2: Select Gender
/// Step 3: Loading
/// Step 4: Result
class NewSessionView extends ConsumerStatefulWidget {
  const NewSessionView({super.key});

  @override
  ConsumerState<NewSessionView> createState() => _NewSessionViewState();
}

class _NewSessionViewState extends ConsumerState<NewSessionView> {
  int _currentStep = 0;
  String? _selectedPresetId;
  ComfyUIModelPreset? _customizedPreset;
  String? _selectedGender;

  ComfyUIModelPreset? get _basePreset {
    if (_selectedPresetId == null) return null;
    switch (_selectedPresetId) {
      case 'realistic':
        return BuiltInPresets.realisticStyle;
      case 'anime':
        return BuiltInPresets.animeStyle;
      case 'pony':
        return BuiltInPresets.semiRealisticPony;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getStepTitle()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: _buildCurrentStep(),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select Style';
      case 1:
        return 'Customize Preset';
      case 2:
        return 'Partner Gender';
      case 3:
        return 'Generating...';
      case 4:
        return 'Ready!';
      default:
        return 'New Session';
    }
  }

  void _handleBack() {
    if (_currentStep > 0 && _currentStep < 3) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPresetSelection();
      case 1:
        return _buildPresetCustomization();
      case 2:
        return _buildGenderSelection();
      case 3:
        return _buildLoadingScreen();
      case 4:
        return _buildResultScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPresetSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Visual Style',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'This determines the AI model used for image generation',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildPresetCard(
                  'realistic',
                  'Realistic',
                  'SDXL',
                  'Photorealistic portraits with fine details',
                  Icons.photo_camera,
                  Colors.blue,
                ),
                _buildPresetCard(
                  'anime',
                  'Anime',
                  'SDXL',
                  'Anime-style with vibrant colors',
                  Icons.brush,
                  Colors.purple,
                ),
                _buildPresetCard(
                  'pony',
                  'Semi-Realistic',
                  'Pony',
                  'Score-based prompting for flexibility',
                  Icons.auto_awesome,
                  Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedPresetId != null
                  ? () {
                      _customizedPreset = _basePreset;
                      setState(() => _currentStep = 1);
                    }
                  : null,
              child: const Text('Next: Customize'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetCard(
    String id,
    String title,
    String category,
    String description,
    IconData icon,
    Color accentColor,
  ) {
    final isSelected = _selectedPresetId == id;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? accentColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedPresetId = id),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: accentColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: accentColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresetCustomization() {
    if (_customizedPreset == null) {
      return const Center(child: Text('No preset selected'));
    }

    return Column(
      children: [
        // Info banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Theme.of(context).colorScheme.primary.withAlpha(20),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Customize the preset settings. These will be used for all images in this session.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        // Editor
        Expanded(
          child: PresetEditor(
            preset: _customizedPreset!,
            onChanged: (updated) {
              _customizedPreset = updated;
            },
          ),
        ),
        // Bottom buttons
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Reset to base preset
                    setState(() {
                      _customizedPreset = _basePreset;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 2),
                  child: const Text('Next: Choose Partner'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who do you want to meet?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your partner\'s gender',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildGenderCard('female', 'Female', Icons.female, Colors.pink),
                _buildGenderCard('male', 'Male', Icons.male, Colors.blue),
                _buildGenderCard('other', 'Other', Icons.transgender, Colors.purple),
                _buildGenderCard('random', 'Random', Icons.casino, Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedGender != null
                  ? () {
                      setState(() => _currentStep = 3);
                      _generateScenario();
                    }
                  : null,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate Partner'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard(String id, String label, IconData icon, Color color) {
    final isSelected = _selectedGender == id;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedGender = id),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isSelected ? color.withAlpha(30) : Colors.grey.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: isSelected ? color : Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 32),
          Text(
            'Creating your partner...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Generating scenario and appearance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 64, color: Colors.green),
            ),
            const SizedBox(height: 32),
            Text(
              'Partner Ready!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Your scenario has been generated.\nTap Start to begin your story.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() => _currentStep = 3);
                    _generateScenario();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reroll'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Create session with _customizedPreset and start
                    context.go('/chat/new-session-id');
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateScenario() async {
    // TODO: Call Scenario Generator agent with _customizedPreset
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() => _currentStep = 4);
    }
  }
}
