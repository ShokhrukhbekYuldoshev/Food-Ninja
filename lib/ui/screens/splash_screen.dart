import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ShaderMask(
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
          Center(
            child: Image.asset(
              "assets/png/logo.png",
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
