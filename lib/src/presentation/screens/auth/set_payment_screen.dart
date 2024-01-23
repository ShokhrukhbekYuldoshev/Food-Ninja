import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/data/models/payment_method.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';

class SetPaymentScreen extends StatefulWidget {
  const SetPaymentScreen({super.key});

  @override
  State<SetPaymentScreen> createState() => _SetPaymentScreenState();
}

class _SetPaymentScreenState extends State<SetPaymentScreen> {
  PaymentMethod _paymentMethod = PaymentMethod.paypal;

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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: PrimaryButton(
                text: "Next",
                onTap: () {
                  // save data to hive
                  var box = Hive.box('myBox');
                  box.put('paymentMethod', _paymentMethod.toString());

                  // navigate to next page
                  Navigator.pushNamed(context, '/register/upload-photo');
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 40,
                  ),
                  const CustomBackButton(),
                  const SizedBox(height: 20),
                  Text(
                    "Payment Method",
                    style: CustomTextStyle.size25Weight600Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "This data will be displayed in your account \nprofile for security",
                    style: CustomTextStyle.size14Weight400Text(),
                  ),
                  const SizedBox(height: 20),
                  // payment method selection between two options: paypal and visa

                  // paypal
                  Ink(
                    decoration: BoxDecoration(
                      color: PaymentMethod.paypal == _paymentMethod
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : AppColors().cardColor,
                      boxShadow: [AppStyles.boxShadow7],
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _paymentMethod = PaymentMethod.paypal;
                        });
                      },
                      borderRadius: AppStyles.largeBorderRadius,
                      child: SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/svg/paypal.svg",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // visa
                  Ink(
                    decoration: BoxDecoration(
                      color: PaymentMethod.visa == _paymentMethod
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : AppColors().cardColor,
                      boxShadow: [AppStyles.boxShadow7],
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _paymentMethod = PaymentMethod.visa;
                        });
                      },
                      borderRadius: AppStyles.largeBorderRadius,
                      child: SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/svg/visa.svg",
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
