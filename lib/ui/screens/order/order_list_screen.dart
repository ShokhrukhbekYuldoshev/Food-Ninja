import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/repositories/order_repository.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/svg/pattern-small.svg",
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders",
                          style: CustomTextStyle.size25Weight600Text(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/cart");
                          },
                          borderRadius: AppStyles.defaultBorderRadius,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryLightColor
                                  .withOpacity(0.1),
                              borderRadius: AppStyles.defaultBorderRadius,
                              boxShadow: [AppStyles.boxShadow7],
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Badge(
                              backgroundColor: AppColors.errorColor,
                              isLabelVisible: OrderRepository.cart.isNotEmpty,
                              label: Text(
                                OrderRepository.cart.length.toString(),
                                style: CustomTextStyle.size14Weight400Text(
                                  Colors.white,
                                ),
                              ),
                              offset: const Offset(10, -10),
                              child: SvgPicture.asset(
                                "assets/svg/cart.svg",
                                colorFilter: const ColorFilter.mode(
                                  AppColors.secondaryDarkColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
