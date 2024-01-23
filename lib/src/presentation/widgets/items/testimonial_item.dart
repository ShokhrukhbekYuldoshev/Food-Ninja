import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:food_ninja/src/presentation/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/models/testimonial.dart';

class TestimonialItem extends StatefulWidget {
  const TestimonialItem({
    super.key,
    required this.testimonial,
  });

  final Testimonial testimonial;

  @override
  State<TestimonialItem> createState() => _TestimonialItemState();
}

class _TestimonialItemState extends State<TestimonialItem> {
  late String userEmail;
  late String? userImage;
  @override
  void initState() {
    super.initState();
    // get user data from reference
    _getUserData();
  }

  Future<void> _getUserData() async {
    final DocumentSnapshot userDoc = await widget.testimonial.user.get();
    final Map<String, dynamic> userData =
        userDoc.data() as Map<String, dynamic>;
    userEmail = userData['email'] as String;
    userImage = userData['image'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildTestimonialItem();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Container _buildTestimonialItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userImage == null
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
              : ClipRRect(
                  borderRadius: AppStyles.largeBorderRadius,
                  child: Image.network(
                    userImage!,
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return ImagePlaceholder(
                        iconData: Icons.person,
                        iconSize: 40,
                        width: 64,
                        height: 64,
                      );
                    },
                  ),
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
                            userEmail,
                            style: CustomTextStyle.size14Weight600Text(),
                          ),
                          Text(
                            formatDate(
                              widget.testimonial.createdAt,
                            ),
                            style: CustomTextStyle.size14Weight400Text(
                              AppColors().secondaryTextColor,
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
                              widget.testimonial.rating.toString(),
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
                  widget.testimonial.review,
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

// testimonial shimmer
class TestimonialShimmerItem extends StatelessWidget {
  const TestimonialShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.primaryColor.withOpacity(0.1),
            highlightColor: AppColors.primaryDarkColor.withOpacity(0.1),
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: AppStyles.largeBorderRadius,
              ),
            ),
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
                          Shimmer.fromColors(
                            baseColor: AppColors.primaryColor.withOpacity(0.1),
                            highlightColor:
                                AppColors.primaryDarkColor.withOpacity(0.1),
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: AppStyles.largeBorderRadius,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Shimmer.fromColors(
                            baseColor: AppColors.primaryColor.withOpacity(0.1),
                            highlightColor:
                                AppColors.primaryDarkColor.withOpacity(0.1),
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: AppStyles.largeBorderRadius,
                              ),
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
                          Shimmer.fromColors(
                            baseColor: AppColors.primaryColor.withOpacity(0.1),
                            highlightColor:
                                AppColors.primaryDarkColor.withOpacity(0.1),
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: AppStyles.largeBorderRadius,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Shimmer.fromColors(
                  baseColor: AppColors.primaryColor.withOpacity(0.1),
                  highlightColor: AppColors.primaryDarkColor.withOpacity(0.1),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: AppColors.primaryColor.withOpacity(0.1),
                  highlightColor: AppColors.primaryDarkColor.withOpacity(0.1),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: AppColors.primaryColor.withOpacity(0.1),
                  highlightColor: AppColors.primaryDarkColor.withOpacity(0.1),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
