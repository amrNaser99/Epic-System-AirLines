abstract class AppState {}

class AppInitial extends AppState {}

class GetAirlineDataLoading extends AppState {}

class GetAirlineDataSuccess extends AppState {}

class GetAirlineDataError extends AppState {
  final String message;

  GetAirlineDataError(this.message);
}

class GetFavouriteCacheLoading extends AppState {}
class GetFavouriteCacheError extends AppState {
  final String message;

  GetFavouriteCacheError(this.message);
}

class GetFavouriteCacheSuccess extends AppState {}

class EmptyFavouriteCache extends AppState {}

class AddFavoriteLoading extends AppState {}

class SaveFavouriteInCacheLoading extends AppState {}
class SaveFavouriteInCacheSuccess extends AppState {}

class AddFavoriteSuccess extends AppState {}

class RemoveFavoriteSuccess extends AppState {}

class AddFavoriteError extends AppState {
  final String message;

  AddFavoriteError(this.message);
}

class ChangeFavouriteState extends AppState {}

class NoInternetConnection extends AppState {}

class HasInternetConnection extends AppState {}

class LaunchUrlLoading extends AppState {}

class LaunchUrlSuccess extends AppState {}
