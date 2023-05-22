import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/ui/widgets/buttons/back_button.dart';
import 'package:food_ninja/ui/widgets/buttons/primary_button.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';
import 'package:food_ninja/utils/helpers.dart';
import 'package:hive/hive.dart';

class RegisterProcessScreen extends StatefulWidget {
  const RegisterProcessScreen({super.key});

  @override
  State<RegisterProcessScreen> createState() => _RegisterProcessScreenState();
}

class _RegisterProcessScreenState extends State<RegisterProcessScreen> {
  // get data from hive
  var box = Hive.box('myBox');

  // form key
  final _formKey = GlobalKey<FormState>();
  // controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    // set data to form fields
    _firstNameController.text = box.get('firstName', defaultValue: '');
    _lastNameController.text = box.get('lastName', defaultValue: '');
    _phoneController.text = box.get('phone', defaultValue: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  // validate form
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  // save data to hive
                  var box = Hive.box('myBox');
                  box.put('firstName', _firstNameController.text.trim());
                  box.put('lastName', _lastNameController.text.trim());
                  box.put('phone', _phoneController.text.trim());
                  // navigate to next page
                  Navigator.pushNamed(context, '/register/set-payment');
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
                  // check if previous page exists
                  if (ModalRoute.of(context)!.canPop) ...[
                    const CustomBackButton(),
                  ],
                  const SizedBox(height: 20),
                  Text(
                    "Fill in your bio to get \nstarted",
                    style: CustomTextStyle.size25Weight600Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "This data will be displayed in your account \nprofile for security",
                    style: CustomTextStyle.size14Weight400Text(),
                  ),
                  const SizedBox(height: 20),
                  // form fields, first name, last name, mobile number
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [AppStyles.boxShadow7],
                          ),
                          child: TextFormField(
                            controller: _firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "First name is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors().cardColor,
                              filled: true,
                              hintText: "First name",
                              hintStyle: CustomTextStyle.size14Weight400Text(
                                AppColors().secondaryTextColor,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                              ),
                              enabledBorder: AppStyles().defaultEnabledBorder,
                              focusedBorder: AppStyles.defaultFocusedBorder(),
                              errorBorder: AppStyles.defaultErrorBorder,
                              focusedErrorBorder:
                                  AppStyles.defaultFocusedErrorBorder,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [AppStyles.boxShadow7],
                          ),
                          child: TextFormField(
                            controller: _lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Last name is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors().cardColor,
                              filled: true,
                              hintText: "Last name",
                              hintStyle: CustomTextStyle.size14Weight400Text(
                                AppColors().secondaryTextColor,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                              ),
                              enabledBorder: AppStyles().defaultEnabledBorder,
                              focusedBorder: AppStyles.defaultFocusedBorder(),
                              errorBorder: AppStyles.defaultErrorBorder,
                              focusedErrorBorder:
                                  AppStyles.defaultFocusedErrorBorder,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [AppStyles.boxShadow7],
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (value) {
                              if (!validatePhoneNumber(value!)) {
                                return "Invalid phone number";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: AppColors().cardColor,
                              filled: true,
                              hintText: "Mobile number",
                              hintStyle: CustomTextStyle.size14Weight400Text(
                                AppColors().secondaryTextColor,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                              ),
                              enabledBorder: AppStyles().defaultEnabledBorder,
                              focusedBorder: AppStyles.defaultFocusedBorder(),
                              errorBorder: AppStyles.defaultErrorBorder,
                              focusedErrorBorder:
                                  AppStyles.defaultFocusedErrorBorder,
                            ),
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
