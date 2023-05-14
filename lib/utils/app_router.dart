import 'package:flutter/material.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/ui/screens/auth/forgot_password_screen.dart';
import 'package:food_ninja/ui/screens/auth/login_screen.dart';
import 'package:food_ninja/ui/screens/auth/otp_screen.dart';
import 'package:food_ninja/ui/screens/auth/register_process_screen.dart';
import 'package:food_ninja/ui/screens/auth/register_screen.dart';
import 'package:food_ninja/ui/screens/auth/register_success_screen.dart';
import 'package:food_ninja/ui/screens/auth/reset_password_screen.dart';
import 'package:food_ninja/ui/screens/auth/set_location_screen.dart';
import 'package:food_ninja/ui/screens/auth/set_payment_screen.dart';
import 'package:food_ninja/ui/screens/auth/upload_photo_screen.dart';
import 'package:food_ninja/ui/screens/explore/food_details_screen.dart';
import 'package:food_ninja/ui/screens/explore/food_list_screen.dart';
import 'package:food_ninja/ui/screens/explore/restaurant_details_screen.dart';
import 'package:food_ninja/ui/screens/explore/restaurant_list_screen.dart';
import 'package:food_ninja/ui/screens/home/home_screen.dart';
import 'package:food_ninja/ui/screens/home/notification_screen.dart';
import 'package:food_ninja/ui/screens/home/settings_screen.dart';
import 'package:food_ninja/ui/screens/onboarding/onboarding_first_screen.dart';
import 'package:food_ninja/ui/screens/onboarding/onboarding_second_screen.dart';
import 'package:food_ninja/ui/screens/order/cart_screen.dart';
import 'package:food_ninja/ui/screens/splash_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/onboarding/first':
        return MaterialPageRoute(
          builder: (_) => const OnboardingFirstScreen(),
        );

      case '/onboarding/second':
        return MaterialPageRoute(
          builder: (_) => const OnboardingSecondScreen(),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case '/register/process':
        return MaterialPageRoute(
          builder: (_) => const RegisterProcessScreen(),
        );

      case '/register/set-payment':
        return MaterialPageRoute(
          builder: (_) => const SetPaymentScreen(),
        );

      case '/register/upload-photo':
        return MaterialPageRoute(
          builder: (_) => const UploadPhotoScreen(),
        );

      case '/register/set-location':
        return MaterialPageRoute(
          builder: (_) => const SetLocationScreen(),
        );

      case '/register/success':
        return MaterialPageRoute(
          builder: (_) => const RegisterSuccessScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case '/login/forgot-password':
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case '/login/forgot-password/otp':
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );

      case '/login/reset-password':
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case '/login/reset-password/success':
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case '/notification':
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );

      case '/restaurants':
        return MaterialPageRoute(
          builder: (_) => const RestaurantListScreen(),
        );

      case '/restaurants/detail':
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: settings.arguments as Restaurant,
          ),
        );

      case '/foods':
        return MaterialPageRoute(
          builder: (_) => const FoodListScreen(),
        );

      case '/foods/detail':
        return MaterialPageRoute(
          builder: (_) => FoodDetailsScreen(
            food: settings.arguments as Food,
          ),
        );

      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case '/cart':
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
