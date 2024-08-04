import 'package:shop_app/models/login_model.dart';

import '../../../../../models/categories_model.dart';
import '../../../../../models/favoutits_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  // final List<ProductModel> products;
  //
  // ShopSuccessHomeDataState(this.products);
}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String? error;

  ShopErrorHomeDataState([this.error]);
}

class ShopSuccessCategoriesDataState extends ShopStates {
  final List<DataModel> categories;

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

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {
  ShopGetFavoritesSuccessState();
}

class ShopGetFavoritesErrorState extends ShopStates {}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {
  LoginModel userModel;
  ShopGetUserDataSuccessState(this.userModel);
}

class ShopGetUserDataErrorState extends ShopStates {}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  LoginModel userModel;
  ShopUpdateUserDataSuccessState(this.userModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {}
