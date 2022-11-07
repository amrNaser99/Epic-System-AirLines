import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/presentation/bloc/app_state.dart';
import '../home/presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: EasySplashScreen(
            backgroundColor: Colors.grey[200]!,
            logoWidth: size.width * 0.5,
            logo: Image.asset(
              'assets/icon.png',
              fit: BoxFit.cover,
            ),
            showLoader: true,
            durationInSeconds: 1,
            loadingText: const Text("Loading..."),
            navigator:  HomeScreen(),
          ),
        );
      },
    );
  }
}
