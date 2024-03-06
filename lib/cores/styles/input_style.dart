import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

final inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
  ),
  hintStyle: TextStyle(
    color: Palette.onDisableColor,
  ),
);
