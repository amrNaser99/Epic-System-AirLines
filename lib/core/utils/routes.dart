import 'package:airline/features/home/presentation/airline_details/airline_details.dart';
import 'package:airline/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/bloc/app_cubit.dart';
import '../../features/home/presentation/home_screen.dart';


class Routes {
  static const String splash = '/splash';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}
