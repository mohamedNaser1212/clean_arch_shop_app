import 'package:shop_app/models/login_model.dart';

import '../../../../../models/favoutits_model.dart';
import '../../../domain/entities/categories_entity/categories_entity.dart';
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

class ShopSuccessCategoriesDataState extends ShopStates {
  final List<CategoriesEntity> categories;

  ShopSuccessCategoriesDataState(this.categories);
}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String? error;

  ShopErrorCategoriesDataState([this.error]);
}

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

class ShopGetFavoritesSuccessState extends ShopStates {
  ShopGetFavoritesSuccessState();
}

class ShopGetFavoritesErrorState extends ShopStates {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {
  LoginModel userModel;
  ShopGetUserDataSuccessState(this.userModel);
}

class ShopCartClearedState extends ShopStates {}

class ShopGetUserDataErrorState extends ShopStates {}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  LoginModel userModel;
  ShopUpdateUserDataSuccessState(this.userModel);
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

class ShopUpdateSelectedProductState extends ShopStates {}

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

class ShopAddCartItemsSuccessState extends ShopStates {
  final bool isAdded;

  ShopAddCartItemsSuccessState(this.isAdded);
}

class ShopAddCartItemsErrorState extends ShopStates {
  final String error;

  ShopAddCartItemsErrorState(this.error);
}

class ShopAddCartItemsLoadingState extends ShopStates {}

class ShopChangeCartSuccessState extends ShopStates {}

class ShopChangeCartLoadingState extends ShopStates {}

class ShopChangeCartErrorState extends ShopStates {
  final String? error;

  ShopChangeCartErrorState([this.error]);
}

class ShopChangeCartItemsSuccessState extends ShopStates {
  final bool isAdded;

  ShopChangeCartItemsSuccessState(this.isAdded);
}

class ShopChangeCartItemsErrorState extends ShopStates {
  final String error;

  ShopChangeCartItemsErrorState(this.error);
}

class ShopChangeCartItemsLoadingState extends ShopStates {}

class ShopRemoveCartItemsSuccessState extends ShopStates {
  final bool isRemoved;

  ShopRemoveCartItemsSuccessState(this.isRemoved);
}

class ShopRemoveCartItemsErrorState extends ShopStates {
  final String error;

  ShopRemoveCartItemsErrorState(this.error);
}

class ShopRemoveCartItemsLoadingState extends ShopStates {}

class ShopCartItemsRemovedState extends ShopStates {}

class ShopClearCartLoadingState extends ShopStates {}

class ShopClearCartSuccessState extends ShopStates {
  final bool isCleared;

  ShopClearCartSuccessState(this.isCleared);
}

class ShopClearCartErrorState extends ShopStates {
  final String error;

  ShopClearCartErrorState(this.error);
}
