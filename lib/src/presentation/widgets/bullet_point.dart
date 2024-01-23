import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.0,
      width: 3.0,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
