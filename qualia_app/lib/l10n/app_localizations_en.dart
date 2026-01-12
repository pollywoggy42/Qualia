// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qualia';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeDescription => 'Choose your preferred appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Select your preferred language';

  @override
  String get comfyUI => 'ComfyUI';

  @override
  String get ipAddress => 'IP Address';

  @override
  String get ipAddressHint => 'Local ComfyUI server address';

  @override
  String get port => 'Port';

  @override
  String get portHint => 'Default: 8188';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get openRouter => 'OpenRouter';

  @override
  String get apiKey => 'API Key';

  @override
  String get apiKeyHint => 'Get your key from openrouter.ai';

  @override
  String get verifySync => 'Verify & Sync';

  @override
  String get authenticated => 'Authenticated';

  @override
  String get notConnected => 'Not Connected';

  @override
  String get creditBalance => 'Credit Balance';

  @override
  String get agentSettings => 'Agent Settings';

  @override
  String get partnerAgent => 'Partner Agent';

  @override
  String get partnerAgentDesc =>
      'Generates partner dialogue, actions, and emotional responses';

  @override
  String get scenarioDirector => 'Scenario Director';

  @override
  String get scenarioDirectorDesc =>
      'Manages narrative flow and world state changes';

  @override
  String get visualDirector => 'Visual Director';

  @override
  String get visualDirectorDesc => 'Creates image prompts from scene context';

  @override
  String get strategist => 'Strategist';

  @override
  String get strategistDesc =>
      'Generates player choice options with success rates';

  @override
  String get scenarioGenerator => 'Scenario Generator';

  @override
  String get scenarioGeneratorDesc =>
      'Creates initial scenarios and partner profiles';

  @override
  String get sdxlTransformer => 'SDXL Transformer';

  @override
  String get sdxlTransformerDesc =>
      'Converts natural language to SDXL prompt tags';

  @override
  String get model => 'Model';

  @override
  String get modelHint => 'LLM model for this agent';

  @override
  String get temperature => 'Temperature';

  @override
  String get temperatureHint =>
      'Creativity level (0 = deterministic, 1 = creative)';

  @override
  String get maxTokens => 'Max Tokens';

  @override
  String get maxTokensHint => 'Maximum response length';

  @override
  String get newSession => 'New Session';

  @override
  String get selectStyle => 'Select Style';

  @override
  String get chooseVisualStyle => 'Choose Visual Style';

  @override
  String get visualStyleDesc =>
      'This determines the AI model used for image generation';

  @override
  String get customizePreset => 'Customize Preset';

  @override
  String get customizePresetInfo =>
      'Customize the preset settings. These will be used for all images in this session.';

  @override
  String get reset => 'Reset';

  @override
  String get next => 'Next';

  @override
  String get nextCustomize => 'Next: Customize';

  @override
  String get nextChoosePartner => 'Next: Choose Partner';

  @override
  String get userGender => 'Your Gender';

  @override
  String get whoAreYou => 'Who are you?';

  @override
  String get selectYourGender => 'Select your gender';

  @override
  String get partnerGender => 'Partner Gender';

  @override
  String get whoToMeet => 'Who do you want to meet?';

  @override
  String get selectPartnerGender => 'Choose your partner\'s gender';

  @override
  String get female => 'Female';

  @override
  String get male => 'Male';

  @override
  String get other => 'Other';

  @override
  String get random => 'Random';

  @override
  String get generatePartner => 'Generate Partner';

  @override
  String get generating => 'Generating...';

  @override
  String get creatingPartner => 'Creating your partner...';

  @override
  String get generatingScenario => 'Generating scenario and appearance';

  @override
  String get ready => 'Ready!';

  @override
  String get partnerReady => 'Partner Ready!';

  @override
  String get scenarioGenerated =>
      'Your scenario has been generated.\nTap Start to begin your story.';

  @override
  String get reroll => 'Reroll';

  @override
  String get start => 'Start';

  @override
  String get realistic => 'Realistic';

  @override
  String get realisticDesc => 'Photorealistic portraits with fine details';

  @override
  String get anime => 'Anime';

  @override
  String get animeDesc => 'Anime-style with vibrant colors';

  @override
  String get semiRealistic => 'Semi-Realistic';

  @override
  String get semiRealisticDesc => 'Score-based prompting for flexibility';

  @override
  String get presetModelConfig => 'Model Configuration';

  @override
  String get checkpointModel => 'Checkpoint Model';

  @override
  String get vae => 'VAE (optional)';

  @override
  String get upscaler => 'Upscaler (optional)';

  @override
  String get generationParams => 'Generation Parameters';

  @override
  String get steps => 'Steps';

  @override
  String get cfgScale => 'CFG Scale';

  @override
  String get sampler => 'Sampler';

  @override
  String get scheduler => 'Scheduler';

  @override
  String get imageSize => 'Image Size';

  @override
  String get portrait => 'Portrait';

  @override
  String get square => 'Square';

  @override
  String get landscape => 'Landscape';

  @override
  String get defaultPrompts => 'Default Prompts';

  @override
  String get positivePrompt => 'Positive Prompt';

  @override
  String get negativePrompt => 'Negative Prompt';

  @override
  String get sessions => 'Sessions';

  @override
  String get noSessions => 'No sessions yet';

  @override
  String get createFirstSession => 'Create your first session to get started';

  @override
  String get chat => 'Chat';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get send => 'Send';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get edit => 'Edit';
}
