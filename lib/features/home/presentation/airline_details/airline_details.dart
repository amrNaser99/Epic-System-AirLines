import 'package:airline/core/utils/app_contstants.dart';
import 'package:airline/core/utils/app_values.dart';
import 'package:airline/core/utils/font_styles.dart';
import 'package:airline/features/home/models/airline_model.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../services/network/api_service/end_points.dart';

class AirlineDetailsScreen extends StatelessWidget {
  final AirLineModel airlineModel;

  const AirlineDetailsScreen({Key? key, required this.airlineModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/logo_white.png', width: 100),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: size.width * 0.9,
                height: size.height * 0.3,
                padding: EdgeInsets.all(AppConst.mainPadding),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: AppConst.borderRadius,
                  boxShadow: AppConst.shadow,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      BASE_URL + airlineModel.logoURL!,
                      fit: BoxFit.cover,
                      width: size.width * 0.4,
                    ),
                    AppSpaces.vSpace20,
                    Text(
                      airlineModel.name!,
                      style: getSemiBoldStyle(
                        fontColor: Colors.black,
                        fontSize: AppSize.s25,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpaces.vSpace20,
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.86,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    InkWell(
                      onTap: () {
                        AppCubit.get(context).launch(Uri.parse(airlineModel.site!));
                      },
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.1,
                        padding: EdgeInsets.all(AppConst.mainPadding),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: AppConst.borderRadius,
                          boxShadow: AppConst.shadow,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(
                              'Site',
                              style: getSemiBoldStyle(
                                fontColor: Colors.black,
                                fontSize: AppSize.s20,
                              ),
                            ),
                            AppSpaces.vSpace20,
                            Text(
                              airlineModel.site!.split('www.')[1],
                              style: getLightStyle(
                                fontColor: AppColors.appColor,
                                fontSize: AppSize.s14,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Tap To Open',
                              style: getLightStyle(
                                fontColor: Colors.blueGrey,
                                fontSize: AppSize.s12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (airlineModel.phone != "")
                      InkWell(
                        onTap: () {
                          debugPrint('onTap');
                          AppCubit.get(context).launch(
                            Uri.parse('tel:${airlineModel.phone}'),
                          );
                        },
                        child: Container(
                          width: size.width * 0.4,
                          height: size.height * 0.1,
                          padding: EdgeInsets.all(AppConst.mainPadding),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: AppConst.borderRadius,
                            boxShadow: AppConst.shadow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                'Phone',
                                style: getSemiBoldStyle(
                                  fontColor: Colors.black,
                                  fontSize: AppSize.s20,
                                ),
                              ),
                              AppSpaces.vSpace20,
                              Text(
                                airlineModel.phone!,
                                style: getLightStyle(
                                  fontColor: AppColors.appColor,
                                  fontSize: AppSize.s14,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Tap To Call',
                                style: getLightStyle(
                                  fontColor: Colors.blueGrey,
                                  fontSize: AppSize.s12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (airlineModel.alliance != "none")
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: airlineModel.alliance!))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to Clipboard'),
                              ),
                            );
                          });
                        },
                        child: Container(
                          width: size.width * 0.4,
                          height: size.height * 0.1,
                          padding: EdgeInsets.all(AppConst.mainPadding),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: AppConst.borderRadius,
                            boxShadow: AppConst.shadow,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  'Alliance',
                                  style: getSemiBoldStyle(
                                    fontColor: Colors.black,
                                    fontSize: AppSize.s20,
                                  ),
                                ),
                                AppSpaces.vSpace20,
                                Text(
                                  airlineModel.alliance!,
                                  style: getLightStyle(
                                    fontColor: AppColors.appColor,
                                    fontSize: AppSize.s14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Tap To Copy',
                                  style: getLightStyle(
                                    fontColor: Colors.blueGrey,
                                    fontSize: AppSize.s12,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    if (airlineModel.code != "none")
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: airlineModel.code!))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to Clipboard'),
                              ),
                            );
                          });
                        },
                        child: Container(
                          width: size.width * 0.4,
                          height: size.height * 0.1,
                          padding: EdgeInsets.all(AppConst.mainPadding),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: AppConst.borderRadius,
                            boxShadow: AppConst.shadow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                'Code',
                                style: getSemiBoldStyle(
                                  fontColor: Colors.black,
                                  fontSize: AppSize.s20,
                                ),
                              ),
                              AppSpaces.vSpace20,
                              Text(
                                airlineModel.code!,
                                style: getLightStyle(
                                  fontColor: AppColors.appColor,
                                  fontSize: AppSize.s14,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
