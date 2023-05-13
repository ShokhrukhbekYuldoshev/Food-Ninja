import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/ui/widgets/testimonial_item.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  background: restaurant.image != null
                      ? Image.network(
                          restaurant.image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/png/no-image.png",
                          fit: BoxFit.cover,
                        ),
                ),
                //Border radius
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 34,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 34,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
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
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                colors: AppColors.primaryGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(rect);
                            },
                            child: Text(
                              'Popular',
                              style: CustomTextStyle.size14Weight400Text(
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/svg/location.svg",
                        ),
                        const SizedBox(width: 12),
                        SvgPicture.asset(
                          "assets/svg/heart.svg",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    restaurant.name,
                    style: CustomTextStyle.size27Weight600Text(),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/star.svg",
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${restaurant.rating} Rating",
                        style: CustomTextStyle.size14Weight400Text(
                          AppColors.grayColor.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(width: 25),
                      SvgPicture.asset(
                        "assets/svg/shopping-bag.svg",
                      ),
                      const SizedBox(width: 10),
                      // TODO: change this to actual number of orders
                      Text(
                        "2000+ Orders",
                        style: CustomTextStyle.size14Weight400Text(
                          AppColors.grayColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // description
                  restaurant.description != null &&
                          restaurant.description!.isNotEmpty
                      ? Text(
                          restaurant.description!,
                          style: CustomTextStyle.size14Weight400Text(),
                        )
                      : Center(
                          child: Text(
                            "No description available",
                            style: CustomTextStyle.size14Weight400Text(
                              AppColors.grayColor.withOpacity(0.3),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  // testimonials
                  Text(
                    "Testimonials",
                    style: CustomTextStyle.size18Weight600Text(),
                  ),
                  const SizedBox(height: 20),
                  restaurant.testimonials.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurant.testimonials.length,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return TestimonialItem(
                              testimonial: restaurant.testimonials[index],
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No testimonials available",
                            style: CustomTextStyle.size14Weight400Text(
                              AppColors.grayColor.withOpacity(0.3),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
