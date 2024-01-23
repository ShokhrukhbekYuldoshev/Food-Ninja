import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                style: CustomTextStyle.size22Weight600Text(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enjoy a fast and smooth food delivery at your \ndoorstep",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              PrimaryButton(
                text: "Next",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/register",
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
