import 'package:airline/core/utils/app_spaces.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:airline/features/home/presentation/widgets/build_airline_item.dart';
import 'package:airline/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


class FavouriteTab extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult>? snapshot;

  const FavouriteTab({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).favoriteList.isNotEmpty,
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildAirlineItem(
                  airlineItem: AppCubit.get(context).favoriteList[index]),
              separatorBuilder: (context, index) => AppSpaces.vSpace20,
              itemCount: AppCubit.get(context).favoriteList.length,
            );
          },
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                Lottie.asset(
                  'assets/empty.json',
                  // width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fill,
                ),
                const Text('No Favourite Airline'),
                const Spacer(flex: 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
