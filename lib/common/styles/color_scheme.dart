import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xFF2C1F63);
const secondaryColor = Color(0xFFDF135C);
const tertiaryColor = Color(0xFFFFC351);
const backgroundColor = Color(0xFFF6F7F9);
const scaffoldBackgroundColor = Color(0xFFFFFFFF);
const primaryTextColor = Color(0xFF1E293B);
const secondaryTextColor = Color(0xFFBBBEC1);
const dividerColor = Color(0xFFE4E4E4);
const errorColor = Color(0xFFD90429);
const successColor = Color(0xFF3E9D9D);
const onDisableColor = Color(0xFFC9C9C9);

// Color scheme
final colorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: scaffoldBackgroundColor,
  secondary: secondaryColor,
  onSecondary: scaffoldBackgroundColor,
  tertiary: tertiaryColor,
  onTertiary: scaffoldBackgroundColor,
  background: backgroundColor,
  onBackground: primaryTextColor,
  error: errorColor,
  errorContainer: errorColor,
  onError: scaffoldBackgroundColor,
);
