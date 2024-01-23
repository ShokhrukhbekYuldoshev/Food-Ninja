import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors().cardColor,
      borderRadius: AppStyles.defaultBorderRadius,
      child: InkWell(
        borderRadius: AppStyles.defaultBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 18,
          ),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(rect);
            },
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: CustomTextStyle.size16Weight400Text(
                Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
