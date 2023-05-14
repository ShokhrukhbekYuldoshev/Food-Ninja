import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/bloc/order/order_bloc.dart';
import 'package:food_ninja/repositories/order_repository.dart';
import 'package:food_ninja/ui/widgets/buttons/back_button.dart';
import 'package:food_ninja/ui/widgets/buttons/secondary_button.dart';
import 'package:food_ninja/ui/widgets/items/cart_item.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppStyles.largeBorderRadius,
                boxShadow: [AppStyles.boxShadow7],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      'assets/svg/pattern-card.svg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                            Text(
                              '\$${OrderRepository.subtotal}',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery fee',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                            Text(
                              '\$${OrderRepository.deliveryFee}',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                            Text(
                              '\$${OrderRepository.discount}',
                              style: CustomTextStyle.size16Weight400Text(
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: CustomTextStyle.size22Weight600Text(
                                Colors.white,
                              ),
                            ),
                            Text(
                              '\$${OrderRepository.total}',
                              style: CustomTextStyle.size22Weight600Text(
                                Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: SecondaryButton(
                                text: "Place Order",
                                onTap: () {},
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      "Cart",
                      style: CustomTextStyle.size25Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: OrderRepository.cart.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Dismissible(
                              key: Key(OrderRepository.cart[index].name),
                              onDismissed: (direction) {
                                BlocProvider.of<OrderBloc>(context).add(
                                  RemoveCompletelyFromCart(
                                    OrderRepository.cart[index],
                                  ),
                                );
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: AppStyles.largeBorderRadius,
                                  color: AppColors.secondaryColor,
                                ),
                                child: SvgPicture.asset(
                                  "assets/svg/trash.svg",
                                ),
                              ),
                              child: CartItem(
                                food: OrderRepository.cart[index],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
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
