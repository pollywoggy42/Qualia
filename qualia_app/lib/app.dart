import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/app_localizations.dart';

import 'config/theme.dart';
import 'config/router.dart';
import 'providers/settings_provider.dart';
import 'providers/locale_provider.dart';

/// Main App Widget
class QualiaApp extends ConsumerWidget {
  const QualiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      title: 'Qualia',
      debugShowCheckedModeBanner: false,
      theme: QualiaTheme.lightTheme(),
      darkTheme: QualiaTheme.darkTheme(),
      themeMode: themeMode,
      routerConfig: appRouter,
      // Localization
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
