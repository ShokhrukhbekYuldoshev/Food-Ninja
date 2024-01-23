import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/bloc/food/food_bloc.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        return InkWell(
          borderRadius: AppStyles.defaultBorderRadius,
          onTap: onTap,
          child: Container(
            height: double.infinity,
            width: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondaryLightColor.withOpacity(0.1),
              borderRadius: AppStyles.defaultBorderRadius,
              boxShadow: [AppStyles().largeBoxShadow],
            ),
            child: SvgPicture.asset(
              "assets/svg/filter.svg",
            ),
          ),
        );
      },
    );
  }
}
