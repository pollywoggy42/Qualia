import 'package:flutter/material.dart';

/// Qualia App Theme Configuration
class QualiaTheme {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryPink = Color(0xFFFF2D55);

  // Semantic Colors
  static const Color affectionPink = Color(0xFFFF69B4);
  static const Color trustBlue = Color(0xFF5AC8FA);
  static const Color arousalOrange = Color(0xFFFF9500);
  static const Color lustRed = Color(0xFFFF3B30);
  static const Color dominancePurple = Color(0xFFAF52DE);

  // Success Rate Colors
  static const Color successHigh = Color(0xFF34C759);
  static const Color successMedium = Color(0xFFFFCC00);
  static const Color successLow = Color(0xFFFF3B30);

  // Chat Bubble Colors
  static const Color partnerBubbleLight = Color(0xFFE9E9EB);
  static const Color partnerBubbleDark = Color(0xFF3A3A3C);
  static const Color userBubble = Color(0xFF007AFF);
  static const Color narratorBg = Color(0x1A8E8E93);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: primaryPink,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      scaffoldBackgroundColor: const Color(0xFFF2F2F7), // iOS 26 Light Gray
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF2F2F7), // iOS 26 Light Gray
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryPink,
        surface: const Color(0xFF1C1C1E),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF1C1C1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
