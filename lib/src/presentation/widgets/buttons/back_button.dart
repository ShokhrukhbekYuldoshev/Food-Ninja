import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      borderRadius: AppStyles.defaultBorderRadius,
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.secondaryLightColor.withOpacity(0.1),
          borderRadius: AppStyles.defaultBorderRadius,
        ),
        child: SvgPicture.asset(
          "assets/svg/back.svg",
        ),
      ),
    );
  }
}
