import 'package:flutter/material.dart';

// Colors
class Palette {
  static Color primaryColor = const Color(0xFF2C1F63);
  static Color secondaryColor = const Color(0xFFDF135C);
  static Color tertiaryColor = const Color(0xFFFFC351);
  static Color backgroundColor = const Color(0xFFF6F7F9);
  static Color scaffoldBackgroundColor = const Color(0xFFFFFFFF);
  static Color primaryTextColor = const Color(0xFF1E293B);
  static Color secondaryTextColor = const Color(0xFFBBBEC1);
  static Color dividerColor = const Color(0xFFE4E4E4);
  static Color errorColor = const Color(0xFFD90429);
  static Color successColor = const Color(0xFF3E9D9D);
  static Color onDisableColor = const Color(0xFFC9C9C9);
}

// Color scheme
final colorScheme = ColorScheme.fromSeed(
  seedColor: Palette.primaryColor,
  brightness: Brightness.light,
  primary: Palette.primaryColor,
  onPrimary: Palette.scaffoldBackgroundColor,
  secondary: Palette.secondaryColor,
  onSecondary: Palette.scaffoldBackgroundColor,
  tertiary: Palette.tertiaryColor,
  onTertiary: Palette.scaffoldBackgroundColor,
  background: Palette.backgroundColor,
  onBackground: Palette.primaryTextColor,
  error: Palette.errorColor,
  errorContainer: Palette.errorColor,
  onError: Palette.scaffoldBackgroundColor,
);
