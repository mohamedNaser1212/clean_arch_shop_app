part of 'favourites_cubit.dart';

class FavouritesState {}

class ShopGetFavoritesLoadingState extends FavouritesState {}

class ShopGetFavoritesSuccessState extends FavouritesState {
  final List<FavouritesEntity> favouritesModel;

  ShopGetFavoritesSuccessState({
    required this.favouritesModel,
  });
}

class ShopGetFavoritesErrorState extends FavouritesState {
  final String error;

  ShopGetFavoritesErrorState({
    required this.error,
  });
}
