import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          child: Text(
            text,
            style: CustomTextStyle.size16Weight500Text(
              textColor,
            ),
          ),
        ),
      ),
    );
  }
}
