import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Example text styles using Google Fonts
  static TextStyle heading1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  static TextStyle heading2 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextStyle bodyText = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );

  static TextStyle caption = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.black54,
    ),
  );

  }// Add more text styles as needed
