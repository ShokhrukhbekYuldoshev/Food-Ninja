import 'package:flutter/material.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 184,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.defaultBorderRadius,
        boxShadow: [AppStyles().largeBoxShadow],
      ),
      child: InkWell(
        borderRadius: AppStyles.defaultBorderRadius,
        onTap: () {
          Navigator.pushNamed(
            context,
            "/restaurants/detail",
            arguments: restaurant,
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 26, 0, 0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: AppStyles.defaultBorderRadius,
                child: restaurant.image == null
                    ? const SizedBox(
                        height: 90,
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.secondaryColor,
                          size: 70,
                        ),
                      )
                    : Image.network(
                        restaurant.image!,
                        height: 90,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 90,
                            child: Icon(
                              Icons.restaurant,
                              color: AppColors.secondaryColor,
                              size: 70,
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                restaurant.name,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.size16Weight600Text(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantItemShimmer extends StatelessWidget {
  const RestaurantItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Ink(
        height: 184,
        decoration: BoxDecoration(
          color: AppColors().cardColor,
          borderRadius: AppStyles.defaultBorderRadius,
          boxShadow: [AppStyles().largeBoxShadow],
        ),
        child: InkWell(
          borderRadius: AppStyles.defaultBorderRadius,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 26, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: AppStyles.defaultBorderRadius,
                    color: AppColors.shimmerBaseColor,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 16,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: AppStyles.defaultBorderRadius,
                    color: AppColors.shimmerBaseColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
