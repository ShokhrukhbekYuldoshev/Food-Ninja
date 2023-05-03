import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/ui/widgets/primary_button.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: PrimaryButton(
                text: "Next",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/onboarding/second",
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
                    "assets/svg/onboarding-1.svg",
                    width: 400,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Find your Comfort \nFood here",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.size22Weight700Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Here You Can find a chef or dish for every \ntaste and color. Enjoy!",
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
