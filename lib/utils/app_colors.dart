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

  // light theme colors
  Color lightBackgroundColor = const Color(0xFFFFFFFF);
  Color lightTextColor = const Color(0xFF000000);

  // dark theme colors
  Color darkBackgroundColor = Colors.black;
  Color darkTextColor = Colors.white;

  // getters
  Color get backgroundColor => ThemeData().brightness == Brightness.light
      ? lightBackgroundColor
      : darkBackgroundColor;

  Color get textColor => ThemeData().brightness == Brightness.light
      ? lightTextColor
      : darkTextColor;
}
