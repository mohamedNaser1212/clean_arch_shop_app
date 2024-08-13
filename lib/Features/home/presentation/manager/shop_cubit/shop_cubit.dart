import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/use_case/carts_use_case/fetch_cart_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/carts_use_case/toggle_cart_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/favourites_use_case/fetch_favourites_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/screens/Cart_screen.dart';
import 'package:shop_app/screens/favorites_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

import '../../../../../core/utils/funactions/save_categories.dart';
import '../../../../../core/utils/funactions/save_products.dart';
import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../core/widgets/end_points.dart';
import '../../../../../screens/categries_screen.dart';
import '../../../../../screens/login_screen.dart';
import '../../../domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import '../../../domain/entities/categories_entity/categories_entity.dart';
import '../../../domain/entities/favourites_entity/favourites_entity.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(
    this.fetchProductsUseCase,
    this.categoriesUseCase,
    this.fetchFavouritesUseCase,
    this.toggleFavouriteUseCase,
    this.addToCartUseCase,
    this.fetchCarUseCase,
  ) : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<ProductEntity>? homeModel;
  List<CategoriesEntity>? categoriesModel;
  List<AddToCartEntity>? cartModel;

  final FetchProductsUseCase fetchProductsUseCase;
  final FetchCategoriesUseCase categoriesUseCase;
  final FetchFavouritesUseCase fetchFavouritesUseCase;
  final ToggleFavouriteUseCase toggleFavouriteUseCase;
  final ToggleCartUseCase addToCartUseCase;
  final FetchCartUseCase fetchCarUseCase;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

  num get cartSubtotal {
    return cartModel?.fold(0, (sum, item) => sum! + (item.price ?? 0)) ?? 0;
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

  Future<void> getHomeData() async {
    emit(ShopLoadingHomeDataState());

    final cachedProducts = await loadProducts(kProductsBox);
    if (cachedProducts.isNotEmpty) {
      homeModel = cachedProducts;
      favorites = {for (var p in cachedProducts) p.id: p.inFavorites ?? false};
      carts = {for (var p in cachedProducts) p.id: p.inCart ?? false};
      emit(ShopSuccessHomeDataState(cachedProducts));
    }

    final result = await fetchProductsUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch products: $failure');
        emit(ShopErrorHomeDataState());
      },
      (products) {
        homeModel = products;
        favorites = {for (var p in products) p.id: p.inFavorites ?? false};
        carts = {for (var p in products) p.id: p.inCart ?? false};
        saveProductsData(products, kProductsBox);
        emit(ShopSuccessHomeDataState(products));
      },
    );
  }

  Future<void> getCategoriesData() async {
    emit(ShopLoadingCategoriesDataState());

    final cachedCategories = await loadCategories(kCategoriesBox);
    if (cachedCategories.isNotEmpty) {
      categoriesModel = cachedCategories;
      emit(ShopSuccessCategoriesDataState(categoriesModel!));
    }

    final result = await categoriesUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch categories: $failure');
        emit(ShopErrorCategoriesDataState());
      },
      (categories) {
        categoriesModel = categories;
        saveCategoriesData(categories, kCategoriesBox);
        emit(ShopSuccessCategoriesDataState(categories));
      },
    );
  }

  Future<void> getCartItems() async {
    emit(ShopGetCartItemsLoadingState());
    final result = await fetchCarUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch cart items: $failure');
        emit(ShopGetCartItemsErrorState(failure.toString()));
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

    final result = await addToCartUseCase.call(prodId);
    result.fold(
      (failure) {
        print('Failed to add/remove cart items: $failure');
        emit(ShopAddCartItemsErrorState(failure.toString()));
      },
      (isAdded) async {
        carts[prodId] = !(carts[prodId] ?? false);
        await getCartItems();
        emit(ShopChangeCartSuccessState());
      },
    );
  }

  Future<Box<AddToCartEntity>> _openCartBox() async {
    if (!Hive.isBoxOpen(kCartBox)) {
      return await Hive.openBox<AddToCartEntity>(kCartBox);
    }
    return Hive.box<AddToCartEntity>(kCartBox);
  }

  ProductEntity? product;

  List<num> prodId = [];
  Future<void> clearCartCache() async {
    var box = await _openCartBox();
    await box.clear();
    prodId.clear();
    carts.clear();

    carts = {for (var p in cartModel!) p.id!: false};

    emit(ShopCartClearedState());
  }

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
        favorites = {for (var p in favourites) p.id!: true};
        emit(ShopGetFavoritesSuccessState());
      },
    );
  }

  Future<void> changeFavourite(num productId) async {
    emit(ShopChangeFavoritesLoadingState());

    final result = await toggleFavouriteUseCase.call(productId);
    result.fold(
      (failure) {
        print('Failed to add/remove favorite items: $failure');
        emit(ShopToggleFavoriteErrorState(failure.toString()));
      },
      (isFavourite) async {
        favorites[productId] = !(favorites[productId] ?? false);
        await getFavorites();
        emit(ShopChangeFavoriteSuccessState(isFavourite));
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
