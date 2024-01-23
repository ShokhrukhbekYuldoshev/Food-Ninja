import 'package:flutter/material.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 150,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles().largeBoxShadow],
      ),
      child: InkWell(
        borderRadius: AppStyles.defaultBorderRadius,
        onTap: () {
          Navigator.pushNamed(
            context,
            "/foods/detail",
            arguments: food,
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: food.image == null
                  ? ImagePlaceholder(
                      width: double.infinity,
                      height: 100,
                      iconData: Icons.fastfood,
                      iconSize: 50,
                    )
                  : Image.network(
                      food.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return ImagePlaceholder(
                          width: double.infinity,
                          height: 100,
                          iconData: Icons.fastfood,
                          iconSize: 50,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              food.name,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.size16Weight600Text(),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${food.price}",
              style: CustomTextStyle.size14Weight400Text(),
            ),
          ],
        ),
      ),
    );
  }
}
