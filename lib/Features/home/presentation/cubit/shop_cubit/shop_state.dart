import '../../../../favourites_feature/data/favourites_models/favoutits_model.dart';
import '../../../../favourites_feature/domain/favourites_entity/favourites_entity.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  final List<ProductEntity> products;

  ShopSuccessHomeDataState(this.products);
}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String? error;

  ShopErrorHomeDataState([this.error]);
}

// class ShopSuccessCategoriesDataState extends ShopStates {
//   final List<CategoriesEntity> categories;
//
//   ShopSuccessCategoriesDataState(this.categories);
// }
//
// class ShopLoadingCategoriesDataState extends ShopStates {}
//
// class ShopErrorCategoriesDataState extends ShopStates {
//   final String? error;
//
//   ShopErrorCategoriesDataState([this.error]);
// }

class BannerChanged extends ShopStates {}

// class ShopSuccessFavoritesState extends ShopStates {}
//
// class ShopLoadingFavoritesState extends ShopStates {}
//
// class ShopErrorFavoritesState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavouriteModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesLoadingState extends ShopStates {}

class ShopChangeFavoritesErrorState extends ShopStates {
  final String? error;

  ShopChangeFavoritesErrorState([this.error]);
}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {
  final List<FavouritesEntity> favouritesModel;

  ShopGetFavoritesSuccessState(this.favouritesModel);
}

class ShopGetFavoritesErrorState extends ShopStates {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopUpdateUserDataErrorState extends ShopStates {}

class ShopToggleFavoriteLoadingState extends ShopStates {}

class ShopToggleFavoriteSuccessState extends ShopStates {
  final ChangeFavouriteModel isFavourite;

  ShopToggleFavoriteSuccessState(this.isFavourite);
}

class ShopChangeFavoriteSuccessState extends ShopStates {
  final bool isFavourite;

  ShopChangeFavoriteSuccessState(this.isFavourite);
}

class ShopToggleFavoriteErrorState extends ShopStates {
  final String error;

  ShopToggleFavoriteErrorState(this.error);
}

class ShopGetCartItemsSuccessState extends ShopStates {}

class ShopGetCartItemsErrorState extends ShopStates {
  final String error;

  ShopGetCartItemsErrorState(this.error);
}

class ShopGetCartItemsLoadingState extends ShopStates {}

class ShopAddCartItemsErrorState extends ShopStates {
  final String error;

  ShopAddCartItemsErrorState(this.error);
}

class ShopAddCartItemsLoadingState extends ShopStates {}

class ShopChangeCartSuccessState extends ShopStates {
  final bool model;

  ShopChangeCartSuccessState(this.model);
}

class ShopChangeCartLoadingState extends ShopStates {}

class ShopChangeCartErrorState extends ShopStates {
  final String? error;

  ShopChangeCartErrorState([this.error]);
}
