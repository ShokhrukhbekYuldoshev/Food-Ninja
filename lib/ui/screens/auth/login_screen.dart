import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/ui/widgets/buttons/primary_button.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: SvgPicture.asset(
                "assets/svg/pattern-big.svg",
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 50,
                        ),
                        Image.asset(
                          "assets/png/logo.png",
                          width: 200,
                        ),
                        const SizedBox(height: 60),
                        Text(
                          'Login To Your Account',
                          style: CustomTextStyle.size20Weight700Text(),
                        ),
                        const SizedBox(height: 40),
                        Form(
                          child: Column(
                            children: [
                              Container(
                                height: AppStyles.defaultTextFieldHeight,
                                decoration: BoxDecoration(
                                  boxShadow: [AppStyles.defaultBoxShadow],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Email",
                                    hintStyle:
                                        CustomTextStyle.size14Weight400Text(
                                      AppColors.grayColor.withOpacity(0.3),
                                    ),
                                    enabledBorder:
                                        AppStyles.defaultEnabledBorder,
                                    focusedBorder:
                                        AppStyles.defaultFocusedBorder,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: AppStyles.defaultTextFieldHeight,
                                decoration: BoxDecoration(
                                  boxShadow: [AppStyles.defaultBoxShadow],
                                ),
                                child: TextFormField(
                                  obscureText: showPassword,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Password",
                                    hintStyle:
                                        CustomTextStyle.size14Weight400Text(
                                      AppColors.grayColor.withOpacity(0.3),
                                    ),
                                    enabledBorder:
                                        AppStyles.defaultEnabledBorder,
                                    focusedBorder:
                                        AppStyles.defaultFocusedBorder,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Icon(
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.grayColor
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/login/forgot-password",
                            );
                          },
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: AppColors.primaryGradient,
                            ).createShader(bounds),
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              "Forgot Password?",
                              style: CustomTextStyle.size12Weight400Text()
                                  .copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: PrimaryButton(
                            text: "Login",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
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
