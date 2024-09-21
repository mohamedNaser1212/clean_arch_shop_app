import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';

import 'Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'Features/settings_feature/domain/settings_use_case/update_user_data_use_case.dart';
import 'Features/settings_feature/domain/settings_use_case/user_sign_out_use_case.dart';
import 'core/payment_gate_way_manager/cubit/payment_cubit.dart';
import 'core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';
import 'core/service_locator/service_locator.dart';
import 'core/utils/widgets/constants.dart';
import 'core/widgets/splash_screen.dart';

void main() {
  // await TokenHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<ProductsCubit>()..getProductsData(context: context)),
        BlocProvider(
            create: (context) => getIt<CategoriesCubit>()..getCategoriesData()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(
            create: (context) => getIt<UserInfoCubit>()..getUserData()),
        BlocProvider(
            create: (context) => getIt<FavouritesCubit>()..getFavorites()),
        BlocProvider(create: (context) => getIt<CartsCubit>()..getCartItems()),
        BlocProvider(
          create: (context) => getIt<ToggleCartCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ToggleFavouriteCubit>(),
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
