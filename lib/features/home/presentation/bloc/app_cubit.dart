import 'dart:convert';

import 'package:airline/features/home/models/airline_model.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:airline/services/local/cache_helper.dart';
import 'package:airline/services/network/dio_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../../../services/network/end_points.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  List<AirLineModel>? airlineList = [];

  void getAirlineData() {
    emit(GetAirlineDataLoading());

    DioHelper.getData(
      url: BASE_URL + AIRLINES,
    ).then((value) {
      value.data.forEach((element) {
        airlineList?.add(AirLineModel.fromJson(element));
      });

      emit(GetAirlineDataSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAirlineDataError(error));
    });
  }

  List<AirLineModel> favoriteList = [];

  void addFavorite({required AirLineModel airlineModel}) {
    emit(AddFavoriteLoading());
    if (!favoriteList.contains(airlineModel) && airlineModel.isFavourite!) {
      favoriteList.add(airlineModel);
      saveFavouriteInCache();
      emit(AddFavoriteSuccess());

    } else if (favoriteList.contains(airlineModel) && airlineModel.isFavourite == false) {

      debugPrint('favoriteList length: ${favoriteList.length}');
      favoriteList.remove(airlineModel);
      saveFavouriteInCache();
      debugPrint('favoriteList after length: ${favoriteList.length}');
      emit(RemoveFavoriteSuccess());
    }
  }

  void saveFavouriteInCache() {
    emit(SaveFavouriteInCacheLoading());
    String favouriteEncode = json.encode(favoriteList);

    CacheHelper.saveData(key: 'favourite', value: favouriteEncode)
        .then((value) {
      debugPrint('saveFavouriteInCache success ');
      emit(SaveFavouriteInCacheSuccess());
    }).catchError((error) {
      AddFavoriteError(error);
    });
  }

  void removeFavouriteInCache() {
    emit(SaveFavouriteInCacheLoading());
    String favouriteEncode = json.encode(favoriteList);

    // remove data from cache
    CacheHelper.removeData(key: 'favourite')
        .then((value) {
      debugPrint('remove cache ');
      emit(RemoveFavoriteSuccess());
    }).catchError((error) {
      AddFavoriteError(error);
    });

    CacheHelper.saveData(key: 'favourite', value: favouriteEncode)
        .then((value) {
      debugPrint('saveFavouriteInCache success ');
      emit(SaveFavouriteInCacheSuccess());
    }).catchError((error) {
      AddFavoriteError(error);
    });
  }


  void getFavouriteCache() {
    emit(GetFavouriteCacheLoading());
    var storedData =  CacheHelper.getData(key: 'favourite');
    if (storedData != null) {
      List<dynamic> favouriteDecode = json.decode(storedData);
      favouriteDecode.forEach((element) {
        favoriteList.add(AirLineModel.fromJson(element));
        debugPrint('getFavouriteCache success $favoriteList');
      });
      emit(GetFavouriteCacheSuccess());
    } else {
      emit(EmptyFavouriteCache());
    }

  }


  void changeFavourite({required AirLineModel item}) {
    item.isFavourite = !item.isFavourite!;
    emit(ChangeFavouriteState());
  }

  void checkInterNetConnection({required BuildContext context}) {


    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        getFavouriteCache();
        emit(NoInternetConnection());
      } else {
        getAirlineData();
        emit(HasInternetConnection());
      }
    });
  }


  List<Widget> tabs = const [
    Tab(
      text: 'Home',
    ),
    Tab(
      text: 'Favourite',
    ),
  ];

//tel:+201000000000
//final Uri _url = Uri.parse('https://flutter.dev');

Future<void> launch(Uri uri) async {
  emit(LaunchUrlSuccess());

  if (!await launchUrl(uri)) {
    throw 'Could not launch $uri';
  }
  emit(LaunchUrlSuccess());
}
}
