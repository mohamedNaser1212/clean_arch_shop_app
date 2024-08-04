import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/models/GetFavouritsModel.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favoutits_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/categries_screen.dart';
import 'package:shop_app/screens/favorites_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../screens/login_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(this.fetchProductsUseCase, this.CategoriesUseCase)
      : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  bool _isDataLoaded = false;
  int currentIndex = 0;

  List<ProductModel>? homeModel;
  List<DataModel>? categoriesModel;
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase CategoriesUseCase;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<num, bool> favorites = {};

  void getHomeData() async {
    emit(ShopLoadingHomeDataState());
    final result = await fetchProductsUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch products: $failure');
        emit(ShopErrorHomeDataState());
      },
      (products) {
        homeModel = products;
        print('Fetched products: $homeModel');
        emit(ShopSuccessHomeDataState());
      },
    );
  }

  void getCategoriesData() async {
    emit(ShopLoadingCategoriesDataState());
    final result = await CategoriesUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch categories: $failure');
        emit(ShopErrorCategoriesDataState());
      },
      (categories) {
        categoriesModel = categories;
        print('Fetched categories: $categoriesModel');
        emit(ShopSuccessCategoriesDataState(categories));
      },
    );
  }

  ChangeFavouriteModel? changeFavouriteModel;

  void changeFavorites(num productId) {
    favorites[productId] = !(favorites[productId] ?? false);
    emit(ShopChangeFavoritesLoadingState());
  }

  GetFavouritsModel? getFavouritesModel;

  void getFavorites() {
    emit(ShopGetFavoritesLoadingState());

    // Here, you would implement API call logic for fetching favorites.
  }

  void signOut(BuildContext context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateUserDataLoadingState());

    // Here, you would implement API call logic for updating user data.
  }
}
