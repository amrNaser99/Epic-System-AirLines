import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:airline/features/home/presentation/widgets/build_airline_item.dart';
import 'package:airline/features/home/presentation/widgets/no_internet_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult>? snapshot;

  const HomeTab({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(snapshot?.data != ConnectivityResult.none){
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AddFavoriteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to favourite'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: AppCubit.get(context).airlineList!.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildAirlineItem(
                  airlineItem: AppCubit.get(context).airlineList![index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: AppCubit.get(context).airlineList!.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else {
      return const NoInternetWidget();
    }
  }
}
