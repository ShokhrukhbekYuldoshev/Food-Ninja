import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/bloc/order/order_bloc.dart';
import 'package:food_ninja/src/presentation/screens/set_location_map_screen.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/loading_indicator.dart';
import 'package:food_ninja/src/presentation/widgets/price_info_widget.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          // remove loading
          Navigator.of(context).pop();
          // show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Order created successfully"),
              backgroundColor: AppColors.primaryColor,
            ),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/order/review",
            arguments: state.order,
            (route) => false,
          );
        } else if (state is OrderCreatingError) {
          // remove loading
          Navigator.of(context).pop();
          // show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorColor,
            ),
          );
        } else if (state is OrderCreating) {
          // show loading
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const LoadingIndicator();
            },
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return PriceInfoWidget(
              onTap: () {
                BlocProvider.of<OrderBloc>(context).add(
                  CreateOrder(),
                );
              },
            );
          },
        ),
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
                        "Confirm Order",
                        style: CustomTextStyle.size25Weight600Text(),
                      ),
                      const SizedBox(height: 20),

                      // delivery address
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors().cardColor,
                          borderRadius: AppStyles.largeBorderRadius,
                          boxShadow: [AppStyles.boxShadow7],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: CustomTextStyle.size16Weight400Text(
                                    AppColors().secondaryTextColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SetLocationMapScreen(),
                                          ),
                                        )
                                        .then(
                                          (value) => BlocProvider.of<OrderBloc>(
                                                  context)
                                              .add(
                                            UpdateUI(),
                                          ),
                                        );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: CustomTextStyle.size16Weight600Text(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/map-pin.svg",
                                ),
                                const SizedBox(width: 14),
                                BlocBuilder<OrderBloc, OrderState>(
                                  builder: (context, state) {
                                    return Expanded(
                                      child: Text(
                                        Hive.box("myBox").get("location"),
                                        style: CustomTextStyle
                                            .size16Weight400Text(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // payment method
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors().cardColor,
                          borderRadius: AppStyles.largeBorderRadius,
                          boxShadow: [AppStyles.boxShadow7],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: CustomTextStyle.size16Weight400Text(
                                    AppColors().secondaryTextColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    buildDialog(context).then(
                                      (value) =>
                                          BlocProvider.of<OrderBloc>(context)
                                              .add(
                                        UpdateUI(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: CustomTextStyle.size16Weight600Text(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<OrderBloc, OrderState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      Hive.box("myBox").get("paymentMethod") ==
                                              "paypal"
                                          ? "assets/svg/paypal.svg"
                                          : "assets/svg/visa.svg",
                                    ),
                                    const SizedBox(width: 14),
                                    BlocBuilder<OrderBloc, OrderState>(
                                      builder: (context, state) {
                                        return Text(
                                          "2121 6352 8465 ****",
                                          style: CustomTextStyle
                                              .size16Weight400Text(),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Select Payment Method",
          style: CustomTextStyle.size18Weight600Text(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Hive.box("myBox").put("paymentMethod", "paypal");
                Navigator.of(context).pop();
              },
              title: SvgPicture.asset(
                "assets/svg/paypal.svg",
              ),
            ),
            ListTile(
              onTap: () {
                Hive.box("myBox").put("paymentMethod", "visa");
                Navigator.of(context).pop();
              },
              title: SvgPicture.asset(
                "assets/svg/visa.svg",
              ),
            ),
          ],
        ),
      );
    },
  );
}
