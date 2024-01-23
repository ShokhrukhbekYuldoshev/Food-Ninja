import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String)? onChanged;

  const SearchField({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.secondaryDarkColor,
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: AppColors.secondaryLightColor.withOpacity(0.1),
          filled: true,
          hintText: "What do you want to order?",
          hintStyle: CustomTextStyle.size14Weight400Text(
            AppColors.secondaryDarkColor.withOpacity(0.4),
          ).copyWith(
            letterSpacing: 0.5,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "assets/svg/search.svg",
            ),
          ),
          enabledBorder: AppStyles().defaultEnabledBorder,
          focusedBorder: AppStyles.defaultFocusedBorder(
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
