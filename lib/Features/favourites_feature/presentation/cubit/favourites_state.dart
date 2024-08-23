part of 'favourites_cubit.dart';

class FavouritesState {}

class ChangeFavoritesLoadingState extends FavouritesState {}

class ChangeFavouriteSuccessState extends FavouritesState {
  final bool isFavourite;

  ChangeFavouriteSuccessState(this.isFavourite);
}

class ToggleFavoriteErrorState extends FavouritesState {
  final String? error;

  ToggleFavoriteErrorState([this.error]);
}

class ShopGetFavoritesLoadingState extends FavouritesState {}

class ShopGetFavoritesSuccessState extends FavouritesState {
  final List<FavouritesEntity> favouritesModel;

  ShopGetFavoritesSuccessState(this.favouritesModel);
}

class ShopGetFavoritesErrorState extends FavouritesState {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}
