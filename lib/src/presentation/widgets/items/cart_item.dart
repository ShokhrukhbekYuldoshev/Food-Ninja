import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/src/bloc/order/order_bloc.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:shimmer/shimmer.dart';

class CartItem extends StatefulWidget {
  final Food food;
  const CartItem({super.key, required this.food});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
      decoration: BoxDecoration(
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
        color: AppColors().cardColor,
      ),
      child: Row(
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
                        return ImagePlaceholder(
                          iconData: Icons.fastfood,
                          iconSize: 30,
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
                const SizedBox(height: 6),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.primaryGradient,
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    "\$${widget.food.price}",
                    style: CustomTextStyle.size18Weight600Text(
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          UpdateQuantityButton(
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            iconColor: AppColors.primaryColor,
            icon: Icons.remove,
            onTap: () {
              BlocProvider.of<OrderBloc>(context).add(
                RemoveFromCart(widget.food),
              );
            },
          ),
          const SizedBox(width: 16),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return Text(
                widget.food.quantity.toString(),
                style: CustomTextStyle.size16Weight400Text(),
              );
            },
          ),
          const SizedBox(width: 16),
          UpdateQuantityButton(
            backgroundColor: AppColors.primaryColor,
            iconColor: Colors.white,
            icon: Icons.add,
            onTap: () {
              BlocProvider.of<OrderBloc>(context).add(
                AddToCart(widget.food),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UpdateQuantityButton extends StatelessWidget {
  const UpdateQuantityButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [AppStyles().largeBoxShadow],
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 16,
        ),
      ),
    );
  }
}

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
        color: AppColors().cardColor,
      ),
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
    );
  }
}
