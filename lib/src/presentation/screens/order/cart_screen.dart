import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/bloc/order/order_bloc.dart';
import 'package:food_ninja/src/data/repositories/order_repository.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/items/cart_item.dart';
import 'package:food_ninja/src/presentation/widgets/price_info_widget.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return PriceInfoWidget(
            onTap: () {
              if (OrderRepository.cart.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Cart is empty"),
                    backgroundColor: AppColors.errorColor,
                  ),
                );
                return;
              }
              Navigator.pushNamed(context, "/order/confirm");
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
                      "Cart",
                      style: CustomTextStyle.size25Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    if (OrderRepository.cart.isEmpty)
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Text(
                          "Cart is empty",
                          style: CustomTextStyle.size16Weight400Text(),
                        ),
                      ),
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
