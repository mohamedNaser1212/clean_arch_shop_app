import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_app/core/utils/funactions/set_up_service_locator.dart';
import 'package:shop_app/core/utils/funactions/start_page.dart';
import 'package:shop_app/core/widgets/cache_helper.dart';
import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/core/widgets/old_dio_helper.dart';

import 'Features/home/data/repos/favourites_repo/favourites_repo.dart';
import 'Features/home/data/repos/home_repo/home_repo.dart';
import 'Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'Features/home/domain/use_case/favourites_use_case/fetch_favourites_use_case.dart';
import 'Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'bloc_observer/bloc_observer.dart';
import 'core/utils/funactions/hive_open_boxes.dart';
import 'core/utils/funactions/hive_register_adapter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  HiveRegisterAdapters();

  await CacheHelper.init();
  DioHelper.init();
  setUpServiceLocator();
  Widget? startingScreen = startPage();
  await hiveOpenBoxes();

  runApp(MyApp(startingScreen: startingScreen!));
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
        final fetchFavourites =
            ToggleFavouriteUseCase(getIt.get<FavouritesRepo>());
        return ShopCubit(
          fetchProductsUseCase,
          fetchCategoriesUseCase,
          fetchFavouritesUseCase,
          fetchFavourites,
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
