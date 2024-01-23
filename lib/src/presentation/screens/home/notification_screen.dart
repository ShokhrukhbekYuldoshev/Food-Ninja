import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
                      "Notification",
                      style: CustomTextStyle.size25Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    NotificationItem(
                      content: "Your order has been taken by the driver",
                      time: DateTime.now(),
                      isSuccess: true,
                    ),
                    const SizedBox(height: 20),
                    NotificationItem(
                      content: "Error while processing your order",
                      time: DateTime.now(),
                      isSuccess: false,
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

class NotificationItem extends StatelessWidget {
  final String content;
  final DateTime time;
  final bool isSuccess;

  const NotificationItem({
    super.key,
    required this.content,
    required this.time,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SvgPicture.asset(
            isSuccess ? "assets/svg/success.svg" : "assets/svg/failure.svg",
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: CustomTextStyle.size16Weight400Text(),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat("dd MMM yyyy, HH:mm").format(time),
                  style: CustomTextStyle.size14Weight400Text(
                    AppColors().secondaryTextColor,
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
