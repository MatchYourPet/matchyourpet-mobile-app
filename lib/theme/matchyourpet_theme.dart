import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchYourPetTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserrat(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.black
    ),
    bodyText2: GoogleFonts.montserrat(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
    headline1: GoogleFonts.zenKakuGothicAntique(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    headline2: GoogleFonts.zenKakuGothicAntique(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.black
    ),
    headline3: GoogleFonts.zenKakuGothicAntique(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: 17.5,
      fontWeight: FontWeight.w500,
      color: Colors.black
    ),
    headline5: GoogleFonts.zenKakuGothicAntique(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: Colors.black
    ),
    headline6: GoogleFonts.zenKakuGothicAntique(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white
    ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.black)
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(182, 44, 60, 1)
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Colors.white, backgroundColor: Color.fromRGBO(182, 44, 60, 1)),
      textTheme: lightTextTheme
    );
  }
}