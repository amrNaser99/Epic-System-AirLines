import 'dart:async';
import 'dart:convert';

import 'package:airline/core/utils/routes.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_contstants.dart';
import '../../../services/local/cache_helper.dart';
import '../../home/presentation/bloc/app_state.dart';

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
      BlocProvider.of<AppCubit>(context).checkInterNetConnection(context: context);
      // BlocProvider.of<AppCubit>(context).getAirlineData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

        if (state is GetAirlineDataSuccess) {
          Navigator.pushReplacementNamed(
            context,
            Routes.home,
          );
        }
      },
      builder: (context, state) {

        return Padding(
          padding:  const EdgeInsets.all(8.0),
          child: EasySplashScreen(
            backgroundColor: Colors.grey[200]!,
            logoWidth: size.width * 0.5,
            logo: Image.asset(
              'assets/icon.png',
              fit: BoxFit.cover,
            ),
            showLoader: true,
            loadingText: const Text("Loading..."),
          ),
        );
      },
    );
  }
}
