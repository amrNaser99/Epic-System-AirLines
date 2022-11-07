import 'package:airline/features/home/presentation/home_screen.dart';
import 'package:airline/services/network/api_service/service_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:airline/core/di/injection.dart';
import 'package:airline/core/utils/app_strings.dart';

import '../../features/home/presentation/bloc/app_cubit.dart';
import '../../features/splash/splash_screen.dart';
import '../utils/app_themes.dart';

class AirLineApp extends StatelessWidget {
  const AirLineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(
              create: (context) => sl<AppCubit>()..getAirLineData(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: AppThemes.lightTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
