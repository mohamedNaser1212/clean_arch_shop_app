import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/onBoarding/onboarding_screen.dart';
import 'package:shop_app/core/utils/funactions/set_up_service_locator.dart';
import 'package:shop_app/core/widgets/cache_helper.dart';
import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/screens/login_screen.dart';

import 'Features/home/data/repos/favourites_repo/favourites_repo.dart';
import 'Features/home/data/repos/home_repo/home_repo.dart';
import 'Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'Features/home/domain/use_case/favourites_use_case/fetch_favourites_use_case.dart';
import 'Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  setUpServiceLocator();
  Widget? startingScreen = start_page();

  runApp(MyApp(startingScreen: startingScreen!));
}

Widget? start_page() {
  bool showBoardingScreen =
      CacheHelper.getData(key: 'showBoardingScreen') ?? true;
  token = CacheHelper.getData(key: 'token') ?? '';
  print(token);
  if (showBoardingScreen) {
    return OnBoardingScreen();
  } else if (token.isEmpty) {
    return LoginScreen();
  } else {
    return LayoutScreen();
  }
}

class MyApp extends StatelessWidget {
  final Widget startingScreen;

  MyApp({required this.startingScreen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final fetchProductsUseCase =
            FetchProductsUseCase(getIt.get<HomeRepo>());
        final fetchCategoriesUseCase =
            FetchCategoriesUseCase(getIt.get<HomeRepo>());
        final fetchFavouritesUseCase =
            FetchFavouritesUseCase(getIt.get<FavouritesRepo>());
        return ShopCubit(
          fetchProductsUseCase,
          fetchCategoriesUseCase,
          fetchFavouritesUseCase,
        )
          ..getHomeData()
          ..getCategoriesData()
          ..getFavorites();
      },
      child: MaterialApp(
        home: startingScreen,
        theme: lightTheme,
      ),
    );
  }
}
