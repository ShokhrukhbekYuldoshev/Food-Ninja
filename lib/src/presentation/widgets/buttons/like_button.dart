import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;
  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          color: AppColors.likeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: AppColors.likeColor,
          size: 16,
        ),
      ),
    );
  }
}
