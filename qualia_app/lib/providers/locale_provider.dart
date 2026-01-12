import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Supported locales
const supportedLocales = [
  Locale('en'),
  Locale('ko'),
];

/// Locale Notifier - 언어 설정 관리
class LocaleNotifier extends Notifier<Locale?> {
  static const _boxName = 'settings';
  static const _localeKey = 'locale';

  @override
  Locale? build() {
    _loadLocale();
    return null; // null means system default
  }

  Future<void> _loadLocale() async {
    try {
      final box = await Hive.openBox(_boxName);
      final localeCode = box.get(_localeKey) as String?;
      if (localeCode != null) {
        state = Locale(localeCode);
      }
    } catch (e) {
      // Ignore errors, use system default
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    try {
      final box = await Hive.openBox(_boxName);
      if (locale == null) {
        await box.delete(_localeKey);
      } else {
        await box.put(_localeKey, locale.languageCode);
      }
    } catch (e) {
      // Ignore storage errors
    }
  }

  String getLocaleName(Locale? locale) {
    if (locale == null) return 'System';
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ko':
        return '한국어';
      default:
        return locale.languageCode;
    }
  }
}

/// Locale Provider
final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale?>(() {
  return LocaleNotifier();
});
