import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // max parent height
      height: double.infinity,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryLightColor.withOpacity(0.1),
        borderRadius: AppStyles.defaultBorderRadius,
        boxShadow: [AppStyles.boxShadow20],
      ),
      child: SvgPicture.asset(
        "assets/svg/filter.svg",
      ),
    );
  }
}
