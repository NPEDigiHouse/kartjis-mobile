import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.montserrat(
    fontSize: 98,
    fontWeight: FontWeight.w300,
  ),
  displayMedium: GoogleFonts.montserrat(
    fontSize: 61,
    fontWeight: FontWeight.w300,
  ),
  displaySmall: GoogleFonts.montserrat(
    fontSize: 49,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: GoogleFonts.montserrat(
    fontSize: 35,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodySmall: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  ),
).apply(
  bodyColor: primaryTextColor,
  displayColor: primaryTextColor,
);
