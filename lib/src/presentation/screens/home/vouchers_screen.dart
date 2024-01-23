import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    const SizedBox(height: 20),
                    Text(
                      "Vouchers",
                      style: CustomTextStyle.size25Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    const VoucherItem(
                      content: "Special deal for this month",
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      buttonTextColor: AppColors.primaryColor,
                      image: "assets/png/voucher-2.png",
                    ),
                    const SizedBox(height: 20),
                    const VoucherItem(
                      content: "Special offer for this week",
                      backgroundColor: Color(0xFFE9F7BA),
                      textColor: Color(0xFF6B3A5B),
                      buttonTextColor: Color(0xFF6B3A5B),
                      image: "assets/png/voucher-3.png",
                    ),
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

class VoucherItem extends StatelessWidget {
  final String image;
  final String content;
  final Color textColor;
  final Color backgroundColor;
  final Color buttonTextColor;

  const VoucherItem({
    super.key,
    required this.image,
    required this.content,
    required this.textColor,
    required this.backgroundColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          alignment: Alignment.centerLeft,
        ),
        color: backgroundColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: AppStyles.defaultBorderRadius,
        boxShadow: [AppStyles().largeBoxShadow],
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              // text and button
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: CustomTextStyle.size16Weight500Text(
                    textColor,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.defaultBorderRadius,
                    ),
                  ),
                  child: Text(
                    "Buy Now",
                    style: CustomTextStyle.size14Weight400Text(buttonTextColor),
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
