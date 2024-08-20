import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/screens/Cart_screen.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/screens/favorites_screen.dart';
import 'package:shop_app/Features/home/presentation/screens/products_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import '../../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../domain/entities/products_entity/product_entity.dart';
import '../../../domain/use_case/home_items_use_case/products_Use_Case.dart';
import '../../screens/categries_screen.dart';
import 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit({
    required this.fetchHomeItemsUseCase,
  }) : super(ProductsInitialState());

  static GetProductsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<ProductEntity>? homeModel;

  final ProductsUseCase fetchHomeItemsUseCase;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

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

  Future<void> getProductsData({required BuildContext context}) async {
    emit(GetProductsLoadingState());

    final result = await fetchHomeItemsUseCase.productsCall();
    result.fold(
      (failure) {
        print('Failed to fetch products: $failure');
        emit(GetProductsErrorState());
      },
      (products) {
        homeModel = products;

        FavouritesCubit.get(context).favorites = {
          for (var p in products) p.id: p.inFavorites ?? false
        };
        CartsCubit.get(context).carts = {
          for (var p in products) p.id: p.inCart ?? false
        };
        print(CartsCubit.get(context).carts);
        emit(GetproductsSuccessState(products));
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
  //
  // void signOut(BuildContext context) {
  //   CacheHelper.removeData(key: 'token').then((value) {
  //     if (value) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //     }
  //   });
  // }

  num? _selectedProductId;

  num? get selectedProductId => _selectedProductId;
}
