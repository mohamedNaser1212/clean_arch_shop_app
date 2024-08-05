import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/favourites_use_case/fetch_favourites_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favoutits_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/categries_screen.dart';
import 'package:shop_app/screens/favorites_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../models/GetFavouritsModel.dart';
import '../../../../../screens/login_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(
    this.fetchProductsUseCase,
    this.CategoriesUseCase,
    this.fetchFavouritesUseCase,
    this.toggleFavouriteUseCase,
  ) : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool _isDataLoaded = false;
  int currentIndex = 0;

  List<ProductModel>? homeModel;
  List<DataModel>? categoriesModel;
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase CategoriesUseCase;
  final FetchFavouritesUseCase fetchFavouritesUseCase;
  final ToggleFavouriteUseCase toggleFavouriteUseCase;

  List<Widget> screens = [
    const ProductsScreen(),
    CategoriesScreen(),
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

  List<Product> getFavouritesModel = [];

  toggleFavourite(num productId) async {
    final isFavourite = favorites[productId] ?? false;
    favorites[productId] = !isFavourite;
    emit(ShopToggleFavoriteLoadingState());
    final result = await toggleFavouriteUseCase(productId);
    result.fold(
      (failure) {
        emit(ShopToggleFavoriteErrorState(failure.toString()));
      },
      (isFavourite) async {
        favorites[productId] = isFavourite;
        _selectedProductId = isFavourite ? productId : null;
        await getFavorites();
        emit(ShopToggleFavoriteSuccessState(isFavourite));
      },
    );
  }

  getFavorites() async {
    emit(ShopGetFavoritesLoadingState());
    var result = await fetchFavouritesUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch favorites: $failure');
        emit(ShopGetFavoritesErrorState(failure.message));
      },
      (favourites) {
        getFavouritesModel = favourites;
        // Update local state to reflect favorites
        favorites = {for (var p in favourites) p.id!: true};
        print('Fetched favorites: $getFavouritesModel');
        emit(ShopGetFavoritesSuccessState());
      },
    );
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

  num? _selectedProductId;

  num? get selectedProductId => _selectedProductId;

  // void toggleFavourite(num productId) async {
  //   final isFavourite = favorites[productId] ?? false;
  //   favorites[productId] = !isFavourite;
  //   emit(ShopToggleFavoriteLoadingState());
  //   final result = await toggleFavouriteUseCase(productId);
  //   result.fold(
  //     (failure) {
  //       emit(ShopToggleFavoriteErrorState(failure.toString()));
  //     },
  //     (isFavourite) {
  //       favorites[productId] = isFavourite;
  //       _selectedProductId = isFavourite ? productId : null;
  //       getFavorites();
  //       emit(ShopToggleFavoriteSuccessState(isFavourite));
  //     },
  //   );
  // }

  void setSelectedProductId(num? productId) {
    _selectedProductId = productId;
    emit(ShopUpdateSelectedProductState());
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateUserDataLoadingState());
  }
}
