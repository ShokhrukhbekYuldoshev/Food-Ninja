import 'package:flutter/material.dart';
import 'package:food_ninja/utils/app_colors.dart';

class AppStyles {
  static final defaultBorderRadius = BorderRadius.circular(15);
  static final largeBorderRadius = BorderRadius.circular(22);
  static const defaultTextFieldHeight = 55.0;

  static final defaultBoxShadow = BoxShadow(
    color: const Color(0xFF5A6CEA).withOpacity(0.07),
    spreadRadius: 0,
    blurRadius: 50,
    offset: const Offset(
      0,
      3,
    ),
  );

  static final defaultEnabledBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
      color: AppColors.borderColor,
    ),
  );

  static final defaultFocusedBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  );

  static final defaultErrorBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
      color: AppColors.errorColor,
    ),
  );

  static final defaultFocusedErrorBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: BorderSide(
      color: AppColors.errorColor,
    ),
  );
}
