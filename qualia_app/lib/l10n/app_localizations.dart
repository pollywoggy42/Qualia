import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Qualia'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred appearance'**
  String get themeDescription;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get languageDescription;

  /// No description provided for @comfyUI.
  ///
  /// In en, this message translates to:
  /// **'ComfyUI'**
  String get comfyUI;

  /// No description provided for @ipAddress.
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get ipAddress;

  /// No description provided for @ipAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Local ComfyUI server address'**
  String get ipAddressHint;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @portHint.
  ///
  /// In en, this message translates to:
  /// **'Default: 8188'**
  String get portHint;

  /// No description provided for @testConnection.
  ///
  /// In en, this message translates to:
  /// **'Test Connection'**
  String get testConnection;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @openRouter.
  ///
  /// In en, this message translates to:
  /// **'OpenRouter'**
  String get openRouter;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiKey;

  /// No description provided for @apiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Get your key from openrouter.ai'**
  String get apiKeyHint;

  /// No description provided for @verifySync.
  ///
  /// In en, this message translates to:
  /// **'Verify & Sync'**
  String get verifySync;

  /// No description provided for @authenticated.
  ///
  /// In en, this message translates to:
  /// **'Authenticated'**
  String get authenticated;

  /// No description provided for @notConnected.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get notConnected;

  /// No description provided for @creditBalance.
  ///
  /// In en, this message translates to:
  /// **'Credit Balance'**
  String get creditBalance;

  /// No description provided for @agentSettings.
  ///
  /// In en, this message translates to:
  /// **'Agent Settings'**
  String get agentSettings;

  /// No description provided for @partnerAgent.
  ///
  /// In en, this message translates to:
  /// **'Partner Agent'**
  String get partnerAgent;

  /// No description provided for @partnerAgentDesc.
  ///
  /// In en, this message translates to:
  /// **'Generates partner dialogue, actions, and emotional responses'**
  String get partnerAgentDesc;

  /// No description provided for @scenarioDirector.
  ///
  /// In en, this message translates to:
  /// **'Scenario Director'**
  String get scenarioDirector;

  /// No description provided for @scenarioDirectorDesc.
  ///
  /// In en, this message translates to:
  /// **'Manages narrative flow and world state changes'**
  String get scenarioDirectorDesc;

  /// No description provided for @visualDirector.
  ///
  /// In en, this message translates to:
  /// **'Visual Director'**
  String get visualDirector;

  /// No description provided for @visualDirectorDesc.
  ///
  /// In en, this message translates to:
  /// **'Creates image prompts from scene context'**
  String get visualDirectorDesc;

  /// No description provided for @strategist.
  ///
  /// In en, this message translates to:
  /// **'Strategist'**
  String get strategist;

  /// No description provided for @strategistDesc.
  ///
  /// In en, this message translates to:
  /// **'Generates player choice options with success rates'**
  String get strategistDesc;

  /// No description provided for @scenarioGenerator.
  ///
  /// In en, this message translates to:
  /// **'Scenario Generator'**
  String get scenarioGenerator;

  /// No description provided for @scenarioGeneratorDesc.
  ///
  /// In en, this message translates to:
  /// **'Creates initial scenarios and partner profiles'**
  String get scenarioGeneratorDesc;

  /// No description provided for @sdxlTransformer.
  ///
  /// In en, this message translates to:
  /// **'SDXL Transformer'**
  String get sdxlTransformer;

  /// No description provided for @sdxlTransformerDesc.
  ///
  /// In en, this message translates to:
  /// **'Converts natural language to SDXL prompt tags'**
  String get sdxlTransformerDesc;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @modelHint.
  ///
  /// In en, this message translates to:
  /// **'LLM model for this agent'**
  String get modelHint;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @temperatureHint.
  ///
  /// In en, this message translates to:
  /// **'Creativity level (0 = deterministic, 1 = creative)'**
  String get temperatureHint;

  /// No description provided for @maxTokens.
  ///
  /// In en, this message translates to:
  /// **'Max Tokens'**
  String get maxTokens;

  /// No description provided for @maxTokensHint.
  ///
  /// In en, this message translates to:
  /// **'Maximum response length'**
  String get maxTokensHint;

  /// No description provided for @newSession.
  ///
  /// In en, this message translates to:
  /// **'New Session'**
  String get newSession;

  /// No description provided for @selectStyle.
  ///
  /// In en, this message translates to:
  /// **'Select Style'**
  String get selectStyle;

  /// No description provided for @chooseVisualStyle.
  ///
  /// In en, this message translates to:
  /// **'Choose Visual Style'**
  String get chooseVisualStyle;

  /// No description provided for @visualStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'This determines the AI model used for image generation'**
  String get visualStyleDesc;

  /// No description provided for @customizePreset.
  ///
  /// In en, this message translates to:
  /// **'Customize Preset'**
  String get customizePreset;

  /// No description provided for @customizePresetInfo.
  ///
  /// In en, this message translates to:
  /// **'Customize the preset settings. These will be used for all images in this session.'**
  String get customizePresetInfo;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @nextCustomize.
  ///
  /// In en, this message translates to:
  /// **'Next: Customize'**
  String get nextCustomize;

  /// No description provided for @nextChoosePartner.
  ///
  /// In en, this message translates to:
  /// **'Next: Choose Partner'**
  String get nextChoosePartner;

  /// No description provided for @userGender.
  ///
  /// In en, this message translates to:
  /// **'Your Gender'**
  String get userGender;

  /// No description provided for @whoAreYou.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get whoAreYou;

  /// No description provided for @selectYourGender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get selectYourGender;

  /// No description provided for @partnerGender.
  ///
  /// In en, this message translates to:
  /// **'Partner Gender'**
  String get partnerGender;

  /// No description provided for @whoToMeet.
  ///
  /// In en, this message translates to:
  /// **'Who do you want to meet?'**
  String get whoToMeet;

  /// No description provided for @selectPartnerGender.
  ///
  /// In en, this message translates to:
  /// **'Choose your partner\'s gender'**
  String get selectPartnerGender;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @generatePartner.
  ///
  /// In en, this message translates to:
  /// **'Generate Partner'**
  String get generatePartner;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @creatingPartner.
  ///
  /// In en, this message translates to:
  /// **'Creating your partner...'**
  String get creatingPartner;

  /// No description provided for @generatingScenario.
  ///
  /// In en, this message translates to:
  /// **'Generating scenario and appearance'**
  String get generatingScenario;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready!'**
  String get ready;

  /// No description provided for @partnerReady.
  ///
  /// In en, this message translates to:
  /// **'Partner Ready!'**
  String get partnerReady;

  /// No description provided for @scenarioGenerated.
  ///
  /// In en, this message translates to:
  /// **'Your scenario has been generated.\nTap Start to begin your story.'**
  String get scenarioGenerated;

  /// No description provided for @reroll.
  ///
  /// In en, this message translates to:
  /// **'Reroll'**
  String get reroll;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @realistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic'**
  String get realistic;

  /// No description provided for @realisticDesc.
  ///
  /// In en, this message translates to:
  /// **'Photorealistic portraits with fine details'**
  String get realisticDesc;

  /// No description provided for @anime.
  ///
  /// In en, this message translates to:
  /// **'Anime'**
  String get anime;

  /// No description provided for @animeDesc.
  ///
  /// In en, this message translates to:
  /// **'Anime-style with vibrant colors'**
  String get animeDesc;

  /// No description provided for @semiRealistic.
  ///
  /// In en, this message translates to:
  /// **'Semi-Realistic'**
  String get semiRealistic;

  /// No description provided for @semiRealisticDesc.
  ///
  /// In en, this message translates to:
  /// **'Score-based prompting for flexibility'**
  String get semiRealisticDesc;

  /// No description provided for @presetModelConfig.
  ///
  /// In en, this message translates to:
  /// **'Model Configuration'**
  String get presetModelConfig;

  /// No description provided for @checkpointModel.
  ///
  /// In en, this message translates to:
  /// **'Checkpoint Model'**
  String get checkpointModel;

  /// No description provided for @vae.
  ///
  /// In en, this message translates to:
  /// **'VAE (optional)'**
  String get vae;

  /// No description provided for @upscaler.
  ///
  /// In en, this message translates to:
  /// **'Upscaler (optional)'**
  String get upscaler;

  /// No description provided for @generationParams.
  ///
  /// In en, this message translates to:
  /// **'Generation Parameters'**
  String get generationParams;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @cfgScale.
  ///
  /// In en, this message translates to:
  /// **'CFG Scale'**
  String get cfgScale;

  /// No description provided for @sampler.
  ///
  /// In en, this message translates to:
  /// **'Sampler'**
  String get sampler;

  /// No description provided for @scheduler.
  ///
  /// In en, this message translates to:
  /// **'Scheduler'**
  String get scheduler;

  /// No description provided for @imageSize.
  ///
  /// In en, this message translates to:
  /// **'Image Size'**
  String get imageSize;

  /// No description provided for @portrait.
  ///
  /// In en, this message translates to:
  /// **'Portrait'**
  String get portrait;

  /// No description provided for @square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get square;

  /// No description provided for @landscape.
  ///
  /// In en, this message translates to:
  /// **'Landscape'**
  String get landscape;

  /// No description provided for @defaultPrompts.
  ///
  /// In en, this message translates to:
  /// **'Default Prompts'**
  String get defaultPrompts;

  /// No description provided for @positivePrompt.
  ///
  /// In en, this message translates to:
  /// **'Positive Prompt'**
  String get positivePrompt;

  /// No description provided for @negativePrompt.
  ///
  /// In en, this message translates to:
  /// **'Negative Prompt'**
  String get negativePrompt;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @noSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet'**
  String get noSessions;

  /// No description provided for @createFirstSession.
  ///
  /// In en, this message translates to:
  /// **'Create your first session to get started'**
  String get createFirstSession;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
