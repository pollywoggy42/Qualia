import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/theme.dart';
import 'config/router.dart';

/// Main App Widget
class QualiaApp extends ConsumerWidget {
  const QualiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Qualia',
      debugShowCheckedModeBanner: false,
      theme: QualiaTheme.lightTheme(),
      darkTheme: QualiaTheme.darkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
