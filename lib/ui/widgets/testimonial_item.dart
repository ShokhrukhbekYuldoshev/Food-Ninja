import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';
import 'package:food_ninja/utils/helpers.dart';

import '../../models/testimonial.dart';

class TestimonialItem extends StatelessWidget {
  const TestimonialItem({
    super.key,
    required this.testimonial,
  });

  final Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          testimonial.userImage == null
              ? Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: AppStyles.largeBorderRadius,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                )
              : Image.network(
                  testimonial.userImage!,
                  height: 64,
                  width: 64,
                ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testimonial.userEmail,
                            style: CustomTextStyle.size14Weight600Text(),
                          ),
                          Text(
                            formatDate(
                              testimonial.createdAt,
                            ),
                            style: CustomTextStyle.size14Weight400Text(
                              AppColors.grayColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 34,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: AppStyles.largeBorderRadius,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.primaryDarkColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/star.svg",
                          ),
                          const SizedBox(width: 5),
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                colors: AppColors.primaryGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(rect);
                            },
                            child: Text(
                              testimonial.rating.toString(),
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  testimonial.comment,
                  style: CustomTextStyle.size14Weight400Text(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
