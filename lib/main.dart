import 'dart:convert';

import 'package:airline/core/app/airline_app.dart';
import 'package:airline/core/app/bloc_observer.dart';
import 'package:airline/core/di/injection.dart';
import 'package:airline/services/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  diInit();
  Bloc.observer = MyBlocObserver();
  runApp(const AirLineApp());
}
