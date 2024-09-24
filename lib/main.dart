import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'package:shop_app/Features/carts_feature/domain/carts_use_case/fetch_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/Features/home/domain/use_case/home_use_case/categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/home_use_case/products_Use_Case.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import 'Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'core/service_locator/service_locator.dart';
import 'core/user_info/cubit/user_info_cubit.dart';
import 'core/utils/constants.dart';
import 'core/widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: lightTheme,
      ),
    );
  }

  List<SingleChildWidget> get _providers {
    return [
      BlocProvider(
        create: (context) {
          final productsCubit = ProductsCubit(
            fetchHomeItemsUseCase: getIt.get<ProductsUseCase>(),
          );
          productsCubit.getProductsData();
          return productsCubit;
        },
      ),
      BlocProvider(
        create: (context) {
          final categoriesCubit = CategoriesCubit(
            fetchCategoriesUseCase: getIt.get<FetchCategoriesUseCase>(),
          );
          categoriesCubit.getCategoriesData();
          return categoriesCubit;
        },
      ),
      // BlocProvider(
      //   create: (context) => LoginCubit(
      //     loginUseCase: getIt.get<LoginUseCase>(),
      //     userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      //   ),
      // ),
      // BlocProvider(
      //   create: (context) => RegisterCubit(
      //     loginUseCase: getIt.get<RegisterUseCase>(),
      //     userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      //   ),
      // ),
      BlocProvider(
        create: (context) {
          final userInfoCubit = UserInfoCubit(
            getUserUseCase: getIt.get<GetUserInfoUseCase>(),
          );
          userInfoCubit.getUserData();

          return userInfoCubit;
        },
      ),
      BlocProvider(
        create: (context) {
          final favouritesCubit = FavouritesCubit(
            fetchFavouritesUseCase: getIt.get<GetFavouritesUseCases>(),
            toggleFavouritesUseCase: getIt.get<ToggleFavouritesUseCase>(),
          );
          favouritesCubit.getFavorites();
          return favouritesCubit;
        },
      ),
      BlocProvider(
        create: (context) {
          final cartsCubit = CartsCubit(
            fetchCartUseCase: getIt.get<FetchCartUseCase>(),
          );
          cartsCubit.getCartItems();

          return cartsCubit;
        },
      ),
      BlocProvider(
        create: (context) => ToggleCartCubit(
          removeCartUseCase: getIt.get<RemoveCartUseCase>(),
          toggleCartUseCase: getIt.get<ToggleCartUseCase>(),
        ),
      ),
      BlocProvider(
        create: (context) => ToggleFavouriteCubit(
          toggleFavouritesUseCase: getIt.get<ToggleFavouritesUseCase>(),
        ),
      ),
    ];
  }
}
