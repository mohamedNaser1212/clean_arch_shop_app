import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_use_case/get_favourites_use_case.dart';
import '../../domain/favourites_use_case/toggle_favourites_use_case.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.fetchFavouritesUseCase,
    required this.toggleFavouritesUseCase,
  }) : super(FavouritesState());
  final GetFavouritesUseCases fetchFavouritesUseCase;
  final ToggleFavouritesUseCase toggleFavouritesUseCase;
  static FavouritesCubit get(context) => BlocProvider.of(context);
  Map<num, bool> favorites = {};

  List<FavouritesEntity> getFavouritesModel = [];
  Future<void> getFavorites() async {
    emit(ShopGetFavoritesLoadingState());

    final result = await fetchFavouritesUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch favorites: $failure');
        emit(ShopGetFavoritesErrorState(failure.message));
      },
      (favourites) {
        getFavouritesModel = favourites;
        favorites = {for (var p in favourites) p.id: true};

        emit(ShopGetFavoritesSuccessState(getFavouritesModel));
      },
    );
  }

  Future<void> changeFavourite(num productId) async {
    emit(ChangeFavoritesLoadingState());
    favorites[productId] = !(favorites[productId] ?? false);
    emit(ChangeFavouriteSuccessState(favorites[productId] ?? false));

    final result = await toggleFavouritesUseCase.call(productIds: productId);

    result.fold(
      (failure) {
        emit(ToggleFavoriteErrorState(error: failure.message));
        favorites[productId] = !(favorites[productId] ?? false);
      },
      (isFavourite) async {
        await getFavorites();
        emit(ChangeFavouriteSuccessState(favorites[productId] ?? false));
      },
    );
  }
}
