import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

final inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
  ),
  hintStyle: const TextStyle(
    color: onDisableColor,
  ),
);
