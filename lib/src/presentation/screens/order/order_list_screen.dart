import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/bloc/order/order_bloc.dart';
import 'package:food_ninja/src/data/repositories/order_repository.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/widgets/items/order_item.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(
      FetchOrders(),
    );
  }

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
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state is OrdersFetching) {
                          // return order item shimmers
                          return Column(
                            children: List.generate(
                              3,
                              (index) => const Column(
                                children: [
                                  OrderItemShimmer(),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        } else if (state is OrdersFetched) {
                          if (state.orders.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No orders yet",
                                      style:
                                          CustomTextStyle.size16Weight400Text(),
                                    ),
                                    const SizedBox(height: 20),
                                    // create order button
                                    PrimaryButton(
                                      text: "Create Order",
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/foods",
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.orders.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  OrderItem(
                                    order: state.orders[index],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        } else if (state is OrderFetchingError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: CustomTextStyle.size16Weight400Text(
                                AppColors.errorColor,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
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
