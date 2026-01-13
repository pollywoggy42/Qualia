import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../models/comfyui_model_preset.dart';
import '../../models/partner_profile.dart';
import '../../providers/scenario_generator_provider.dart';
import '../../services/agents/scenario_generator.dart';
import 'package:uuid/uuid.dart';
import '../../models/session.dart';
import '../../models/user_profile.dart';
import '../../models/world_state.dart';
import '../../models/models.dart';
import '../../providers/session_provider.dart';
import '../../widgets/glass_card.dart';
import 'widgets/preset_editor.dart';
import 'widgets/partner_editor.dart';

/// New Session View - Session creation flow
/// Step 0: Select Preset
/// Step 1: Customize Preset
/// Step 2: Gender Selection (User + Partner combined)
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
  String? _selectedUserGender;
  String? _selectedPartnerGender;
  PartnerProfile? _generatedPartner;
  ScenarioInfo? _scenarioInfo;
  String? _generationError;

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
        title: Text(_getStepTitle(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: _buildCurrentStep(),
    );
  }

  String _getStepTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (_currentStep) {
      case 0:
        return l10n.selectStyle;
      case 1:
        return l10n.customizePreset;
      case 2:
        return l10n.userGender; // Combined gender selection
      case 3:
        return l10n.generating;
      case 4:
        return l10n.ready;
      default:
        return l10n.newSession;
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
        return _buildGenderSelection(); // Combined gender selection
      case 3:
        return _buildLoadingScreen();
      case 4:
        return _buildResultScreen();
      default:
        return Center(
          child: Text('Error: Unknown step $_currentStep'),
        );
    }
  }

  Widget _buildPresetSelection() {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.chooseVisualStyle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.visualStyleDesc,
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
                  l10n.realistic,
                  'SDXL',
                  l10n.realisticDesc,
                  Icons.photo_camera,
                  Colors.blue,
                ),
                _buildPresetCard(
                  'anime',
                  l10n.anime,
                  'SDXL',
                  l10n.animeDesc,
                  Icons.brush,
                  Colors.purple,
                ),
                _buildPresetCard(
                  'pony',
                  l10n.semiRealistic,
                  'Pony',
                  l10n.semiRealisticDesc,
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
              child: Text(l10n.nextCustomize),
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

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      isSelected: isSelected,
      selectedBorderColor: accentColor,
      onTap: () => setState(() => _selectedPresetId = id),
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
                    GlassChip(
                      label: category,
                      color: accentColor,
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
                  child: const Text('Next: Your Gender'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Combined Gender Selection - User + Partner in one screen
  Widget _buildGenderSelection() {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Gender Section
          Text(
            l10n.whoAreYou,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.selectYourGender,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          // User Gender Grid
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(child: _buildGenderCard('female', l10n.female, Icons.female, Colors.pink, true)),
                const SizedBox(width: 12),
                Expanded(child: _buildGenderCard('male', l10n.male, Icons.male, Colors.blue, true)),
                const SizedBox(width: 12),
                Expanded(child: _buildGenderCard('other', l10n.other, Icons.transgender, Colors.purple, true)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Partner Gender Section
          Text(
            l10n.whoToMeet,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.selectPartnerGender,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          // Partner Gender Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildGenderCard('female', l10n.female, Icons.female, Colors.pink, false),
                _buildGenderCard('male', l10n.male, Icons.male, Colors.blue, false),
                _buildGenderCard('other', l10n.other, Icons.transgender, Colors.purple, false),
                _buildGenderCard('random', l10n.random, Icons.casino, Colors.orange, false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Generate Button (larger size)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedUserGender != null && _selectedPartnerGender != null
                  ? () {
                      setState(() => _currentStep = 3);
                      _generateScenario();
                    }
                  : null,
              icon: const Icon(Icons.auto_awesome),
              label: Text(l10n.generatePartner),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Unified gender card builder for both user and partner
  Widget _buildGenderCard(String id, String label, IconData icon, Color color, bool isUserGender) {
    final isSelected = isUserGender 
        ? _selectedUserGender == id
        : _selectedPartnerGender == id;
    
    return GlassCard(
      isSelected: isSelected,
      selectedBorderColor: color,
      onTap: () => setState(() {
        if (isUserGender) {
          _selectedUserGender = id;
        } else {
          _selectedPartnerGender = id;
        }
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? color.withAlpha(30) : Colors.grey.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: isSelected ? color : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? color : null,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLoadingScreen() {
    final scenarioState = ref.watch(scenarioGenerationProvider);

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
            scenarioState.isLoading
                ? 'Generating scenario and appearance'
                : 'Preparing your story...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          if (scenarioState.hasError) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Using sample data (API not configured)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orange[800],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    if (_generatedPartner == null) {
      return const Center(child: Text('No partner generated'));
    }

    return Column(
      children: [
        // Info banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.green.withAlpha(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 18, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Partner generated! Review and edit the details, then start your story.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              if (_scenarioInfo != null) ...[
                const SizedBox(height: 8),
                Text(
                  _scenarioInfo!.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _scenarioInfo!.setting,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
              ],
              if (_generationError != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Using sample data (configure OpenRouter API key for AI generation)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.orange[800],
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        // Partner Editor
        Expanded(
          child: PartnerEditor(
            profile: _generatedPartner!,
            onChanged: (updated) {
              _generatedPartner = updated;
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
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() => _currentStep = 4);
                    _generateScenario();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reroll'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _createAndStartSession(),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Story'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _generateScenario() async {
    setState(() {
      _generationError = null;
    });

    final partnerGender = _selectedPartnerGender == 'random'
        ? ['female', 'male', 'other'][DateTime.now().millisecond % 3]
        : _selectedPartnerGender!;

    try {
      // Try to use the ScenarioGenerator agent
      final result = await ref.read(scenarioGenerationProvider.notifier).generate(
        userGender: _selectedUserGender!,
        partnerGender: partnerGender,
      );

      if (mounted) {
        if (result != null) {
          setState(() {
            _generatedPartner = result.partner;
            _scenarioInfo = result.scenario;
            _currentStep = 4;
          });
        } else {
          // Fallback to sample data if generation fails
          setState(() {
            _generatedPartner = generateSamplePartner(gender: partnerGender);
            _scenarioInfo = null;
            _currentStep = 4;
          });
        }
      }
    } catch (e) {
      // Fallback to sample data on error
      if (mounted) {
        setState(() {
          _generatedPartner = generateSamplePartner(gender: partnerGender);
          _scenarioInfo = null;
          _generationError = e.toString();
          _currentStep = 4;
        });
      }
    }
  }

  Future<void> _createAndStartSession() async {
    if (_generatedPartner == null || _customizedPreset == null) return;

    // 1. Create User Profile (Basic defaults for now)
    final userProfile = UserProfile(
      name: 'User', // TODO: Add name input
      age: 25,
      gender: _selectedUserGender ?? 'male',
      occupation: 'Traveler',
      location: 'Unknown',
      face: const VisualDescriptor(description: 'Average face', sdxlTags: 'average face'),
      hairstyle: const VisualDescriptor(description: 'Short hair', sdxlTags: 'short hair'),
      body: const VisualDescriptor(description: 'Average build', sdxlTags: 'average build'),
      accessories: const VisualDescriptor(description: 'None', sdxlTags: ''),
      outfit: const VisualDescriptor(description: 'Casual clothes', sdxlTags: 'casual clothes'),
      personality: const Personality(mbti: 'ISTP', speechStyle: 'Direct', traits: ['Curious']),
    );

    // 2. Create Initial World State
    final worldState = WorldState(
      currentTime: DateTime.now(),
      weather: 'Clear',
      emotionalAtmosphere: 'New Beginning',
    );

    // 3. Create Session
    final sessionId = const Uuid().v4();
    final session = Session(
      id: sessionId,
      createdAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
      partner: _generatedPartner!,
      user: userProfile,
      worldState: worldState,
      modelPreset: _customizedPreset!,
      isNSFWEnabled: false, // Default
    );

    // 4. Save to Storage
    await ref.read(sessionListProvider.notifier).createSession(session);

    // 5. Navigate
    if (mounted) {
      context.go('/chat/$sessionId');
    }
  }
}
