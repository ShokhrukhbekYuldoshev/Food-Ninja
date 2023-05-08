import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/ui/widgets/buttons/primary_button.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: PrimaryButton(
                text: "Next",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/register",
                  );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Align(
              child: Column(
                children: [
                  const SizedBox(height: 56),
                  SvgPicture.asset(
                    "assets/svg/onboarding-2.svg",
                    width: 400,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Food Ninja is Where Your Comfort \nFood Lives",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.size22Weight700Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enjoy a fast and smooth food delivery at your \ndoorstep",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.size12Weight400Text(),
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
