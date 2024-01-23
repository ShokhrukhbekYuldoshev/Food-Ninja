import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:food_ninja/src/bloc/theme/theme_bloc.dart';
import 'package:food_ninja/src/presentation/utils/app_router.dart';
import 'package:food_ninja/src/presentation/utils/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ThemeData themeData =
            Hive.box('myBox').get('isDarkMode', defaultValue: false)
                ? AppTheme().darkThemeData
                : AppTheme().lightThemeData;
        if (state is ThemeChanged) {
          themeData = state.themeData;
        }

        return MaterialApp(
          title: "Food Ninja",
          theme: themeData,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
