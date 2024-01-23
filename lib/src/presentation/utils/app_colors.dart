import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppColors {
  // general colors
  static const Color primaryColor = Color(0xFF53E88B);
  static const Color primaryDarkColor = Color(0xFF15BE77);
  static List<Color> primaryGradient = [
    primaryColor,
    primaryDarkColor,
  ];
  static const Color secondaryColor = Color(0xFFFEAD1D);
  static const Color secondaryLightColor = Color(0xFFF9A84D);
  static const Color secondaryDarkColor = Color(0xFFDA6317);
  static const Color errorColor = Color(0xFFFF4B4B);
  static const Color successColor = Color(0xFF388E3C);
  static const Color likeColor = Color(0xFFFF1D1D);
  static const Color starColor = Color(0xFFFEAD1D);
  static Color starEmptyColor = starColor.withOpacity(0.3);
  static const Color lightBorderColor = Color(0xFFF4F4F4);
  static const Color grayColor = Color(0xFF3B3B3B);
  static const Color grayLightColor = Color(0xFFF6F6F6);
  // for order status
  // pending,
  // preparing,
  // delivering,
  // delivered,
  // canceled;

  // for order status
  static const Color pendingColor = starColor;
  static const Color preparingColor = secondaryColor;
  static const Color deliveringColor = Colors.blue;
  static const Color deliveredColor = successColor;
  static const Color canceledColor = errorColor;

  // shimmer colors
  static const Color shimmerBaseColor = Color(0xFFE0E0E0);
  static const Color shimmerHighlightColor = Color(0xFFF5F5F5);

  // light theme colors
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightTextColor = Color(0xFF000000);
  static const Color lightCardColor = Color(0xFFFFFFFF);

  // dark theme colors
  static const Color darkBackgroundColor = Colors.black;
  static const Color darkTextColor = Colors.white;
  static const Color darkCardColor = Color(0xFF252525);

  // getters
  Color backgroundColor = Hive.box("myBox").get("isDarkMode") == false
      ? lightBackgroundColor
      : darkBackgroundColor;

  Color textColor = Hive.box("myBox").get("isDarkMode") == false
      ? lightTextColor
      : darkTextColor;

  Color cardColor = Hive.box("myBox").get("isDarkMode") == false
      ? lightCardColor
      : darkCardColor;

  Color secondaryTextColor = Hive.box("myBox").get("isDarkMode") == false
      ? grayColor.withOpacity(0.3)
      : grayLightColor.withOpacity(0.3);

  Color borderColor = Hive.box("myBox").get("isDarkMode") == false
      ? lightBorderColor
      : Colors.transparent;
}
