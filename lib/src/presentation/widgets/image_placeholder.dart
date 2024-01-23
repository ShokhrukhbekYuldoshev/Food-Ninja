import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';

// ignore: must_be_immutable
class ImagePlaceholder extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  double? width;
  double? height;

  ImagePlaceholder({
    super.key,
    required this.iconData,
    required this.iconSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        iconData,
        color: AppColors.secondaryColor,
        size: iconSize,
      ),
    );
  }
}
