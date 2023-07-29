import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffA01596);
const Color secondaryColor = Color(0xffE80D61);
const Color orange = Color(0xffEB8820);

const Color white = Color(0xffffffff);

final Color whitWithOpacity = white.withOpacity(0.3);

const String font = 'Sukar';
ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: white,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: white,
      centerTitle: true,
      titleTextStyle: TextStyle(color: primaryColor, fontFamily: font, fontSize: 24, fontWeight: FontWeight.bold)),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: primaryColor, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(color: primaryColor, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: primaryColor, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(color: white, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    bodyMedium: TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: white, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal),
    displayLarge: TextStyle(color: secondaryColor, fontFamily: font, fontSize: 20, fontWeight: FontWeight.w800),
    displayMedium: TextStyle(color: orange, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(color: white, fontFamily: font, fontSize: 12, fontWeight: FontWeight.normal),
  ),
  iconTheme: const IconThemeData(color: primaryColor),

  // Text Form Field style
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 22,
      horizontal: 26,
    ),
    filled: true,
    fillColor: white.withOpacity(0.3),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1, color: white.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1, color: white.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.1, color: Colors.red.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10)),
    errorStyle: const TextStyle(color: orange, fontFamily: font, fontSize: 14, fontWeight: FontWeight.bold),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.1, color: Colors.red.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10)),
    errorMaxLines: 1,
    labelStyle: const TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    prefixStyle: const TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
    counterStyle: const TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
  ),

  // colorScheme: ColorScheme(
  //   primary: ,
  //   brightness: Brightness.light,
  //   background: white),
);
TextStyle buttonTextStyle1 =
    const TextStyle(color: white, fontFamily: font, fontSize: 18, fontWeight: FontWeight.normal);
TextStyle buttonTextStyle2 =
    const TextStyle(color: orange, fontFamily: font, fontSize: 18, fontWeight: FontWeight.normal);

TextStyle largeOrangeStyle =
    const TextStyle(color: orange, fontFamily: font, fontSize: 20, fontWeight: FontWeight.bold);

TextStyle smallOrangeStyle = const TextStyle(
  color: white,
  fontFamily: font,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);

TextStyle smallPinkStyle = const TextStyle(
  color: secondaryColor,
  fontFamily: font,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);

abstract class AppColors {
  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLigth = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);
}
