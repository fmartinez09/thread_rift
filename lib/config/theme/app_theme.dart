import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color(0xFF151D31);
const scaffoldBackgroundColor = Color(0xFFF3F3F3);

class AppTheme {

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.mulish()
        .copyWith( fontSize: 35, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.mulish()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.mulish()
        .copyWith( fontSize: 15 )
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.mulish()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.mulish()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),
    )
  );

}