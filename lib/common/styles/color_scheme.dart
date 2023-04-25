import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0XFF2C1F63);
const secondaryColor = Color(0XFFDF135C);
const tertiaryColor = Color(0XFFFFC351);
const backgroundColor = Color(0XFFF6F7F9);
const scaffoldBackgroundColor = Color(0XFFFFFFFF);
const primaryTextColor = Color(0XFF1E293B);
const secondaryTextColor = Color(0XFFBBBEC1);
const dividerColor = Color(0XFFE4E4E4);
const errorColor = Color(0XFFD90429);
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
