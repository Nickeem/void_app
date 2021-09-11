import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff000000), // Color(0xFF2E2F36);
    cardColor: Color(0xfffbfafe),
    primaryColor: Color(0xFFd81e27),
    shadowColor: Color(0xFF324754).withOpacity(0.24),
    textTheme: TextTheme(
      headline4: GoogleFonts.gruppo(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4,
      ),
      headline5: GoogleFonts.chango(
        color: Color(0xFFFFFFFF),
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headline6: GoogleFonts.montserrat(
        color: Color(0xFF324754),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.montserrat(
        color: Color(0xFF324754),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 12,
      ),
      subtitle2: GoogleFonts.montserrat(
        color: Color(0xFF819ab1),
        fontSize: 12,
      ),
      button: GoogleFonts.montserrat(
        color: Colors.white,
        letterSpacing: 0.8,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}