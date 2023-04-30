// onGenerate Route

import 'package:flutter/material.dart';
import 'package:food_ninja/ui/screens/auth/login_screen.dart';
import 'package:food_ninja/ui/screens/home/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Page not found!'),
            ),
          ),
        );
    }
  }
}
