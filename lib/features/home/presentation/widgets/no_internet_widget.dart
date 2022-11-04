import 'package:airline/core/utils/app_color.dart';
import 'package:airline/core/utils/app_strings.dart';
import 'package:airline/core/utils/font_styles.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_spaces.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Lottie.asset('assets/internet_connection_error.json'),
            AppSpaces.hSpace20,
            Text(
              AppStrings.notInternetConnection,
              style: getBoldStyle(fontColor: AppColors.appColor, fontSize: 25),
            ),
            AppSpaces.vSpace10,
            Text(
              'Please Check your Internet Connection \n and Try Again',
              style: getMediumStyle(fontColor: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.tryAgain,
                style: getLightStyle(
                  fontColor: AppColors.appColor,
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
