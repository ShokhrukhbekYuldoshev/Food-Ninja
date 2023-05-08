import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      var box = Hive.box('myBox');

      if (box.get('isRegistered') == true) {
        Navigator.pushReplacementNamed(context, "/home");
      } else if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, "/register/process");
      } else {
        Navigator.pushReplacementNamed(context, "/onboarding/first");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _visible ? 0 : 1000,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/png/logo.png",
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
