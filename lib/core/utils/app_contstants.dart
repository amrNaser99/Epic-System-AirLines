import 'package:airline/core/utils/app_color.dart';
import 'package:airline/features/home/models/airline_model.dart';
import 'package:flutter/material.dart';

class AppConst {
  static final borderRadius = BorderRadius.circular(20);
  static double fontSizeM = 13.0;
  static double fontSizeL = 16.0;
  static double radius = 50.0;
  static double mainPadding = 20.0;

  static var shadow =[
    BoxShadow(
      color: Colors.grey.withOpacity(0.9),
      spreadRadius: 5,
      blurRadius: 9,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ];
  static var linearGradiant =LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.generateMaterialColor(AppColors.appColor)
          .withOpacity(0.5),
      AppColors.generateMaterialColor(AppColors.accentColor)
    ],
  );
  static String? cacheFav ;


}
