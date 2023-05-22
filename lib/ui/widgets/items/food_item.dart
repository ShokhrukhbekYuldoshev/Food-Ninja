import 'package:flutter/material.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/services/firestore_db.dart';
import 'package:food_ninja/ui/widgets/image_placeholder.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';
import 'package:shimmer/shimmer.dart';

class FoodItem extends StatefulWidget {
  final Food food;
  const FoodItem({super.key, required this.food});

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  final FirestoreDatabase _db = FirestoreDatabase();
  String category = "";
  @override
  void initState() {
    super.initState();
    _db.getDocumentFromReference(widget.food.category).then((value) {
      if (mounted) {
        setState(() {
          var map = value.data() as Map<String, dynamic>;
          category = map["name"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
        color: AppColors().cardColor,
      ),
      child: InkWell(
        borderRadius: AppStyles.largeBorderRadius,
        onTap: () {
          Navigator.pushNamed(
            context,
            "/foods/detail",
            arguments: widget.food,
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [AppStyles().largeBoxShadow],
                ),
                child: ClipRRect(
                  borderRadius: AppStyles.defaultBorderRadius,
                  child: widget.food.image == null
                      ? ImagePlaceholder(
                          iconData: Icons.fastfood,
                          iconSize: 30,
                        )
                      : Image.network(
                          widget.food.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      style: CustomTextStyle.size16Weight400Text(),
                    ),
                    Text(
                      category,
                      style: CustomTextStyle.size14Weight400Text(
                        AppColors().secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "\$${widget.food.price}",
                style: CustomTextStyle.size22Weight600Text(
                  AppColors.secondaryDarkColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItemShimmer extends StatelessWidget {
  const FoodItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
        color: AppColors().cardColor,
      ),
      child: InkWell(
        borderRadius: AppStyles.largeBorderRadius,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [AppStyles().largeBoxShadow],
                    color: AppColors.shimmerBaseColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.shimmerHighlightColor,
                      child: Container(
                        height: 16,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [AppStyles().largeBoxShadow],
                          color: AppColors.shimmerBaseColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.shimmerHighlightColor,
                      child: Container(
                        height: 16,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [AppStyles().largeBoxShadow],
                          color: AppColors.shimmerBaseColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [AppStyles().largeBoxShadow],
                    color: AppColors.shimmerBaseColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
