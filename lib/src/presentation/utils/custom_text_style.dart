import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';

class CustomTextStyle {
  static TextStyle size30Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size27Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size25Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
      height: 1.5,
      letterSpacing: 0.5,
    );
  }

  static TextStyle size22Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size20Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size18Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size16Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size16Weight500Text([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size16Weight400Text([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors().textColor,
      height: 1.5,
      letterSpacing: 0.5,
    );
  }

  static TextStyle size14Weight600Text([Color? color]) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size14Weight400Text([Color? color]) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors().textColor,
    );
  }
}
