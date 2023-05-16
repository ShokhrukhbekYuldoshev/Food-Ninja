import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/food/food_bloc.dart';
import 'package:food_ninja/bloc/login/login_bloc.dart';
import 'package:food_ninja/bloc/order/order_bloc.dart';
import 'package:food_ninja/bloc/profile/profile_bloc.dart';
import 'package:food_ninja/bloc/register/register_bloc.dart';
import 'package:food_ninja/repositories/order_repository.dart';
import 'package:food_ninja/services/hive_adapters.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:food_ninja/bloc/restaurant/restaurant_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FirestoreDocumentReferenceAdapter());
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(TestimonialAdapter());
  Hive.registerAdapter(FoodAdapter());
  await Hive.openBox('myBox');
  OrderRepository.loadCart();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RestaurantBloc(),
        ),
        BlocProvider(
          create: (context) => FoodBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Ninja",
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryColor,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.backgroundColor,
          indicatorColor: AppColors.primaryColor.withOpacity(0.1),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
