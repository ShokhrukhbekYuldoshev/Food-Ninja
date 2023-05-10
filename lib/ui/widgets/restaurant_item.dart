import 'package:flutter/material.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 184,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: AppStyles.defaultBorderRadius,
        boxShadow: [AppStyles.boxShadow20],
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
                child: Image.network(
                  restaurant.image,
                  height: 90,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/png/no-image.png",
                      height: 90,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name,
                    style: CustomTextStyle.size16Weight600Text(),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.star,
                    color: AppColors.starColor,
                    size: 16,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: CustomTextStyle.size14Weight400Text(
                      AppColors.grayColor,
                    ),
                  ),
                ],
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
          color: AppColors.cardColor,
          borderRadius: AppStyles.defaultBorderRadius,
          boxShadow: [AppStyles.boxShadow20],
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
