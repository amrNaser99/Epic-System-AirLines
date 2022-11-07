import 'dart:convert';
import 'package:airline/features/home/models/airline_model.dart';
import 'package:airline/features/home/presentation/bloc/app_state.dart';
import 'package:airline/services/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/network/api_service/service_helper.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  List<AirLineModel>? airlineList = [];

  void getAirLineData () {
    emit(GetAirlineDataLoading());
    fetchAllData().then((value) {
      airlineList = value;
      emit(GetAirlineDataSuccess());
    }).catchError((error) {
      emit(GetAirlineDataError(error.toString()));
    });
  }

  List<AirLineModel> favoriteList = [];

  void addFavorite({required AirLineModel airlineModel}) {
    emit(AddFavoriteLoading());
    if (!favoriteList.contains(airlineModel) && airlineModel.isFavourite!) {
      favoriteList.add(airlineModel);
      saveFavouriteInCache();
      emit(AddFavoriteSuccess());
    } else if (favoriteList.contains(airlineModel) &&
        airlineModel.isFavourite == false) {
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
    CacheHelper.removeData(key: 'favourite').then((value) {
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
    var storedData = CacheHelper.getData(key: 'favourite');
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

  List<Widget> tabs = const [
    Tab(
      text: 'Home',
    ),
    Tab(
      text: 'Favourite',
    ),
  ];

  Future<void> launch(Uri uri) async {
    emit(LaunchUrlSuccess());

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
    emit(LaunchUrlSuccess());
  }
}