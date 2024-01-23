import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';

class AppTheme {
  ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors().backgroundColor,
      indicatorColor: AppColors.primaryColor.withOpacity(0.1),
      surfaceTintColor: Colors.transparent,
    ),
    // change text button style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondaryDarkColor,
      ),
    ),
    // change checkbox style
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        AppColors.secondaryLightColor.withOpacity(0.1),
      ),
      checkColor: MaterialStateProperty.all(
        AppColors.secondaryDarkColor,
      ),
    ),
    // change app bar surface tint color
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
    ),
    // change cursor color
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),
    // change dialog surface tint color
    dialogTheme: const DialogTheme(
      surfaceTintColor: Colors.transparent,
    ),
  );

  ThemeData darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors().backgroundColor,
    primaryColor: AppColors.primaryColor,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors().backgroundColor,
      indicatorColor: AppColors.primaryColor.withOpacity(0.1),
      surfaceTintColor: Colors.transparent,
    ),
    // change text button style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondaryDarkColor,
      ),
    ),
    // change checkbox style
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        AppColors.secondaryLightColor.withOpacity(0.1),
      ),
      checkColor: MaterialStateProperty.all(
        AppColors.secondaryDarkColor,
      ),
    ),
    // change app bar surface tint color
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
    ),
    // change cursor color
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),
    // change dialog surface tint color
    dialogTheme: const DialogTheme(
      surfaceTintColor: Colors.transparent,
    ),
  );
}
