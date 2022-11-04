import 'package:get_it/get_it.dart';

import '../../features/home/presentation/bloc/app_cubit.dart';

final sl = GetIt.instance;

Future<void> diInit() async {
  sl.registerFactory(() => AppCubit());
}
