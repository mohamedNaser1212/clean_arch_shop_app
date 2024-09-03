part of 'toggle_favourite_cubit.dart';

class ToggleFavouriteState {}

class ToggleFavoritesLoadingState extends ToggleFavouriteState {}

class ToggleFavouriteSuccessState extends ToggleFavouriteState {
  final bool isFavourite;

  ToggleFavouriteSuccessState(this.isFavourite);
}

class ToggleFavoriteErrorState extends ToggleFavouriteState {
  final String error;

  ToggleFavoriteErrorState({
    required this.error,
  });
}
