// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightGreenTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.lightGreen,
    primarySwatch: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.lightGreen),
    fontFamily: "inter",
  );


  static ThemeData indigoTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.indigo,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.indigo),
    fontFamily: "inter",
  );


  static ThemeData darkGrey = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.grey.shade900,
    primarySwatch: Colors.grey,
    cardColor: Colors.grey.shade100,
    bottomAppBarColor: Colors.grey.shade200,
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.grey.shade900),
    fontFamily: "inter",
  );


  static ThemeData orangeTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.orange,
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
    fontFamily: "inter",
  );


  static ThemeData redTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.red),
    fontFamily: "inter",
  );

  // static ThemeData blueTheme = ThemeData(
  //   useMaterial3: false,
  //   primaryColor: Colors.lightBlue,
  //   primarySwatch: Colors.blue,
  //   scaffoldBackgroundColor: Color(0xFFF5F5F5),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     foregroundColor: Colors.black,
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.lightBlue,
  //   ),
  //   fontFamily: "inter",
  // );
}
