import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({super.key});

  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen> {
  @override
  void initState() {
    super.initState();

    bool isDarkMode = Hive.box("myBox").get("isDarkMode", defaultValue: false);
    if (isDarkMode) {
      Hive.box("myBox").put("isDarkMode", true);
    } else {
      Hive.box("myBox").put("isDarkMode", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                style: CustomTextStyle.size22Weight600Text(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Here You Can find a chef or dish for every \ntaste and color. Enjoy!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              PrimaryButton(
                text: "Next",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/onboarding/second",
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
