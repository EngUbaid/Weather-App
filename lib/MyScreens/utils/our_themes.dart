import 'package:flutter/material.dart';
import 'package:weather/MyScreens/consts/colors.dart';

class CustomThemes {
  // Light theme
  static final lightTheme = ThemeData(
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.grey,
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
  );
  //Dark Theme
  static final darkTheme = ThemeData(
    cardColor: Colors.black,
    scaffoldBackgroundColor: bgColor,
    primaryColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
