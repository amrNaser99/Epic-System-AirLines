import 'package:airline/core/utils/app_color.dart';
import 'package:airline/core/utils/app_spaces.dart';
import 'package:airline/core/utils/font_styles.dart';
import 'package:airline/features/home/models/airline_model.dart';
import 'package:airline/features/home/presentation/bloc/app_cubit.dart';
import 'package:airline/services/network/end_points.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/routes.dart';
import '../airline_details/airline_details.dart';

class BuildAirlineItem extends StatelessWidget {
  final AirLineModel airlineItem;

  const BuildAirlineItem({
    Key? key,
    required this.airlineItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AirlineDetailsScreen(
                    airlineModel: airlineItem,
                  )),
        );
      },
      child: Container(
        width: size.width,
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.appColor, width: 0.5),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              BASE_URL + airlineItem.logoURL!,
              width: size.width * 0.3,
              height: size.height * 0.15,
            ),
            AppSpaces.hSpace20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    airlineItem.name!,
                    style: getBoldStyle(
                        fontColor: AppColors.appColor, fontSize: 16),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.changeFavourite(item: airlineItem);
                cubit.addFavorite(airlineModel: airlineItem);
                debugPrint('${airlineItem.usName} Favourite');
              },
              icon: airlineItem.isFavourite == false
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
