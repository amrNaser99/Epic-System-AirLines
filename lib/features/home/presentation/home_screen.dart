import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:airline/features/home/presentation/widgets/favourite_tab.dart';
import 'package:airline/features/home/presentation/widgets/home_tab.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset('assets/logo_white.png', width: 100),
                  elevation: 10,
                  bottom: TabBar(
                    tabs: cubit.tabs,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3.0,
                    physics: const NeverScrollableScrollPhysics(),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                ),
                body:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TabBarView(children: [
                    HomeTab(snapshot: snapshot),
                    FavouriteTab(snapshot: snapshot),
                  ]),
                ),
              ),
            );
          },
        );
      },

    );
  }
}
