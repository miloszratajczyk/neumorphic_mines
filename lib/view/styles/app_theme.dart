import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._(); // Prevents initialization

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: textTheme,
    colorSchemeSeed: _randomColor(),
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: textTheme,
    colorSchemeSeed: _randomColor(),
  );

  static final textTheme = TextTheme(
    displayMedium: GoogleFonts.podkova(
      fontSize: 128,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16,
    ),
    labelMedium: GoogleFonts.podkova(
      fontSize: 16,
    ),
  );
}

Color _randomColor() =>
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
