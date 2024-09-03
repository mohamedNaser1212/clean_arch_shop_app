import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';

part 'toggle_favourite_state.dart';

class ToggleFavouriteCubit extends Cubit<ToggleFavouriteState> {
  ToggleFavouriteCubit({
    required this.toggleFavouritesUseCase,
  }) : super(ToggleFavouriteState());
  static ToggleFavouriteCubit get(context) => BlocProvider.of(context);
  final ToggleFavouritesUseCase toggleFavouritesUseCase;
  Future<void> changeFavourite(num productId) async {
    emit(ToggleFavoritesLoadingState());
    // favorites[productId] = !(favorites[productId] ?? false);

    final result = await toggleFavouritesUseCase.call(productIds: productId);

    result.fold(
      (failure) {
        // favorites[productId] = !(favorites[productId] ?? false);
        emit(ToggleFavoriteErrorState(error: failure.message));
      },
      (isFavourite) {
        // await getFavorites();
        emit(ToggleFavouriteSuccessState(isFavourite));
        //   favorites[productId] ?? false
      },
    );
  }
}
