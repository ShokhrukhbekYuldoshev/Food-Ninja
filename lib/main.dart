import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:food_ninja/src/app.dart';
import 'package:food_ninja/src/bloc/chat/chat_bloc.dart';
import 'package:food_ninja/src/bloc/food/food_bloc.dart';
import 'package:food_ninja/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:food_ninja/src/bloc/login/login_bloc.dart';
import 'package:food_ninja/src/bloc/order/order_bloc.dart';
import 'package:food_ninja/src/bloc/profile/profile_bloc.dart';
import 'package:food_ninja/src/bloc/register/register_bloc.dart';
import 'package:food_ninja/src/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_ninja/src/bloc/settings/settings_bloc.dart';
import 'package:food_ninja/src/bloc/testimonial/testimonial_bloc.dart';
import 'package:food_ninja/src/bloc/theme/theme_bloc.dart';
import 'package:food_ninja/src/data/repositories/order_repository.dart';
import 'package:food_ninja/src/data/services/hive_adapters.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FirestoreDocumentReferenceAdapter());
  Hive.registerAdapter(RestaurantAdapter());
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
          create: (context) => ForgotPasswordBloc(),
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
        BlocProvider(
          create: (context) => TestimonialBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
