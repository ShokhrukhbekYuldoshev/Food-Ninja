import 'package:flutter/material.dart';
import 'package:food_ninja/utils/app_colors.dart';

class CustomTextStyle {
  static TextStyle size22Weight700Text([Color? color]) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size16Weight400Text([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size16Weight700Text([Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
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

  static TextStyle size14Weight700Text([Color? color]) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size12Weight400Text([Color? color]) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors().textColor,
    );
  }

  static TextStyle size12Weight700Text([Color? color]) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors().textColor,
    );
  }
}
