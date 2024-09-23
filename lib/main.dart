import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/features/carts_feature/domain/carts_use_case/fetch_cart_use_case.dart';
import 'package:shop_app/features/carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import 'package:shop_app/features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import 'package:shop_app/features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shop_app/features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shop_app/features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/features/home/domain/use_case/home_use_case/categories_use_case.dart';
import 'package:shop_app/features/home/domain/use_case/home_use_case/products_Use_Case.dart';
import 'package:shop_app/features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit.dart';
import 'package:shop_app/features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import 'features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'features/settings_feature/domain/settings_use_case/update_user_data_use_case.dart';
import 'features/settings_feature/domain/settings_use_case/user_sign_out_use_case.dart';
import 'core/payment_gate_way_manager/cubit/payment_cubit.dart';
import 'core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';
import 'core/service_locator/service_locator.dart';
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
      providers: [
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
        BlocProvider(
          create: (context) => LoginCubit(
            loginUseCase: getIt.get<LoginUseCase>(),
            userDataUseCase: getIt.get<GetUserInfoUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            loginUseCase: getIt.get<RegisterUseCase>(),
            userDataUseCase: getIt.get<GetUserInfoUseCase>(),
          ),
        ),
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
            cartsCubit.getCartItems(); // Fetch cart items after initializing
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
        BlocProvider(
          create: (context) => PaymentCubit(
            paymentUseCase: getIt.get<PaymentUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateUserDataCubit(
            updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => SignOutCubit(
            userSignOutUseCase: getIt.get<UserSignOutUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: lightTheme,
      ),
    );
  }
}
