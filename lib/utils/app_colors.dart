import 'package:flutter/material.dart';

class AppColors {
  // general colors
  static Color primaryColor = const Color(0xFF53E88B);
  static Color primaryDarkColor = const Color(0xFF15BE77);
  static List<Color> primaryGradient = [
    primaryColor,
    primaryDarkColor,
  ];
  static Color secondaryColor = const Color(0xFFFEAD1D);
  static Color secondaryLightColor = const Color(0xFFF9A84D);
  static Color secondaryDarkColor = const Color(0xFFDA6317);
  static Color errorColor = const Color(0xFFFF4B4B);
  static Color successColor = const Color(0xFF388E3C);
  static Color likeColor = const Color(0xFFFF1D1D);
  static Color starColor = const Color(0xFFFEAD1D);
  static Color starEmptyColor = starColor.withOpacity(0.3);
  static Color borderColor = const Color(0xFFF4F4F4);
  static Color grayColor = const Color(0xFF3B3B3B);
  static Color grayLightColor = const Color(0xFFF6F6F6);

  // light theme colors
  static Color lightBackgroundColor = const Color(0xFFFFFFFF);
  static Color lightTextColor = const Color(0xFF000000);
  static Color lightCardColor = const Color(0xFFFFFFFF);

  // dark theme colors
  static Color darkBackgroundColor = Colors.black;
  static Color darkTextColor = Colors.white;
  static Color darkCardColor = Colors.black.withOpacity(0.1);

  // getters
  static Color get backgroundColor => ThemeData().brightness == Brightness.light
      ? lightBackgroundColor
      : darkBackgroundColor;

  static Color get textColor => ThemeData().brightness == Brightness.light
      ? lightTextColor
      : darkTextColor;

  static Color get cardColor => ThemeData().brightness == Brightness.light
      ? lightCardColor
      : darkCardColor;
}
