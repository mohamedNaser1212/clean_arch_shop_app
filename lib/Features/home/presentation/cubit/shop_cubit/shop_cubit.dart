import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/screens/Cart_screen.dart';
import 'package:shop_app/Features/favourites_feature/presentation/screens/favorites_screen.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/Features/home/presentation/screens/products_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import '../../../../../core/utils/screens/widgets/cache_helper.dart';
import '../../../../../core/utils/screens/widgets/end_points.dart';
import '../../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../../carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../../carts_feature/domain/carts_use_case/get_cart_use_case.dart';
import '../../../../carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import '../../../../carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import '../../../domain/entities/products_entity/product_entity.dart';
import '../../../domain/use_case/home_items_use_case/products_Use_Case.dart';
import '../../screens/categries_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(
    this.fetchHomeItemsUseCase,
    //  this.fetchFavouritesUseCase,
    this.addToCartUseCase,
    this.removeFromCartUseCase,
    this.toggleCartUseCase,
    //  this.toggleFavouritesUseCase,
    //  this.fetchCategoriesUseCase,
  ) : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<ProductEntity>? homeModel;
  // List<CategoriesEntity>? categoriesModel;
  List<AddToCartEntity> cartModel = [];

  final productsUseCase fetchHomeItemsUseCase;
  // final CategoriesUseCase fetchCategoriesUseCase;
  // final GetFavouritesUseCases fetchFavouritesUseCase;
  // final ToggleFavouritesUseCase toggleFavouritesUseCase;
  final FetchCartUseCase addToCartUseCase;
  final RemoveCartUseCase removeFromCartUseCase;
  final ToggleCartUseCase toggleCartUseCase;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

  num get cartSubtotal {
    return cartModel.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  num get cartTotal => cartSubtotal;

  List<BottomNavigationBarItem> get bottomNavigationBarItems {
    return [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.apps), label: 'Categories'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: 'Favorites'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart), label: 'Carts'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Settings'),
    ];
  }

  void changeScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Future<void> getProductsData() async {
    emit(ShopLoadingHomeDataState());

    final result = await fetchHomeItemsUseCase.productsCall();
    result.fold(
      (failure) {
        print('Failed to fetch products: $failure');
        emit(ShopErrorHomeDataState());
      },
      (products) {
        homeModel = products;
        favorites = {for (var p in products) p.id: p.inFavorites ?? false};
        carts = {for (var p in products) p.id: p.inCart ?? false};
        print(carts);
        emit(ShopSuccessHomeDataState(products));
      },
    );
  }

  /*

  BlocConsumerCategories =>
   loading? progressindicator
   : success? BlocConsumerProducts =>
      loading? progressindicator
      : success? screenDesign
   */

  // Future<void> getCategoriesData() async {
  //   emit(ShopLoadingCategoriesDataState());
  //
  //   final result = await fetchCategoriesUseCase.categoriesCall();
  //   result.fold(
  //     (failure) {
  //       print('Failed to fetch categories: $failure');
  //       emit(ShopErrorCategoriesDataState());
  //     },
  //     (categories) {
  //       categoriesModel = categories;
  //       emit(ShopSuccessCategoriesDataState(categories));
  //     },
  //   );
  // }

  Future<void> getCartItems() async {
    emit(ShopGetCartItemsLoadingState());

    final result = await addToCartUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch cart items: $failure');
        emit(ShopGetCartItemsErrorState(failure.message));
      },
      (cartItems) {
        cartModel = cartItems;
        carts = {for (var p in cartItems) p.id!: true};
        emit(ShopGetCartItemsSuccessState());
      },
    );
  }

  Future<void> changeCarts(num prodId) async {
    emit(ShopChangeCartLoadingState());
    carts[prodId] = !(carts[prodId] ?? false);

    final result = await toggleCartUseCase.toggleCartCall(prodId);
    result.fold(
      (failure) {
        print('Failed to add/remove cart items: $failure');
        emit(ShopAddCartItemsErrorState(failure.toString()));
      },
      (isAdded) async {
        await getCartItems();
        emit(ShopChangeCartSuccessState(carts[prodId] ?? false));
      },
    );
  }

  changeCartsList(List<num> prodIds) async {
    emit(ShopChangeCartLoadingState());

    try {
      bool allRemoved = true;

      for (var prodId in prodIds) {
        final result = await removeFromCartUseCase.removeFromCartCall(prodId);
        if (result.isLeft()) {
          print('Failed to remove item with id $prodId');
          allRemoved = false; // Mark as false if any item fails to be removed
        }
      }

      if (allRemoved) {
        // Remove from cache
        for (var prodId in prodIds) {
          carts.remove(prodId);
        }

        // Update product list
        cartModel.removeWhere((item) => prodIds
            .contains(item.id)); // Ensure items are removed from cartModel

        emit(ShopChangeCartSuccessState(allRemoved));
      } else {
        emit(ShopAddCartItemsErrorState(
            "Failed to remove some items from the cart"));
      }

      return allRemoved; // Ensure a boolean is returned
    } catch (e) {
      print('Error in changeCartsList: $e');
      emit(ShopAddCartItemsErrorState(e.toString()));
      return false; // Return false if an exception occurs
    }
  }

  ProductEntity? product;

  // List<FavouritesEntity> getFavouritesModel = [];
  // Future<void> getFavorites() async {
  //   emit(ShopGetFavoritesLoadingState());
  //
  //   final result = await fetchFavouritesUseCase.call();
  //   result.fold(
  //     (failure) {
  //       print('Failed to fetch favorites: $failure');
  //       emit(ShopGetFavoritesErrorState(failure.message));
  //     },
  //     (favourites) {
  //       getFavouritesModel = favourites;
  //       favorites = {for (var p in favourites) p.id!: true};
  //
  //       emit(ShopGetFavoritesSuccessState(getFavouritesModel));
  //     },
  //   );
  // }
  //
  // Future<void> changeFavourite(num productId) async {
  //   emit(ShopChangeFavoritesLoadingState());
  //
  //   final result = await toggleFavouritesUseCase.toggleFavouriteCall(productId);
  //   result.fold(
  //     (failure) {
  //       print('Failed to add/remove favorite items: $failure');
  //       emit(ShopToggleFavoriteErrorState(failure.toString()));
  //     },
  //     (isFavourite) async {
  //       favorites[productId] = !(favorites[productId] ?? false);
  //       await getFavorites();
  //       emit(ShopChangeFavoriteSuccessState(favorites[productId] ?? false));
  //     },
  //   );
  // }

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
}
