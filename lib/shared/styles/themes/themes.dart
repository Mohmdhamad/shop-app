import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors/colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  primarySwatch: defaultColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: CircleBorder(),
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ),
    titleSpacing: 20.0,
    actionsIconTheme: IconThemeData(color: Colors.white),
    color: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 27.0,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrangeAccent,
    unselectedItemColor: Colors.grey,
    elevation: 45.0,
    backgroundColor: HexColor('333739'),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
  ),
  fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: false,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: CircleBorder(),
  ),

  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[300],
      statusBarIconBrightness: Brightness.dark,
    ),
    titleSpacing: 20.0,
    actionsIconTheme: IconThemeData(color: Colors.black54),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 27.0,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 45.0,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
  ),
  fontFamily: 'Jannah',
);
