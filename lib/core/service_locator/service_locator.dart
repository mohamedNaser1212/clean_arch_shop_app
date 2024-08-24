import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_local_data_source.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_remote_data_source.dart';
import 'package:shop_app/Features/carts_feature/data/carts_repo_impl/carts_repo_impl.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_repo/cart_repo.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/get_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/favourite_remote_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/favourites_local_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_repo_impl/favourites_repo_impl.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/home/data/data_sources/home_remote_data_sources/home_remote_data_source.dart';
import 'package:shop_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:shop_app/Features/home/domain/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/search_feature/data/search_data_source/search_remote_data_source.dart';
import 'package:shop_app/Features/search_feature/data/search_repo_impl/search_repo_impl.dart';
import 'package:shop_app/Features/search_feature/domain/search_repo/search_repo.dart';
import 'package:shop_app/Features/search_feature/domain/search_use_case/fetch_search_use_case.dart';
import 'package:shop_app/Features/settings_feature/data/user_data_data_source/user_remote_remote_data_source.dart';
import 'package:shop_app/Features/settings_feature/data/user_data_repo_impl/user_data_repo_impl.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/get_user_data_use_case/user_data_use_case.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/get_user_data_use_case/user_sign_out_use_case.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';

import '../../Features/authentication_feature/data/authentication_data_sources/authentication_remote_data_source.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../Features/home/data/data_sources/home_local_data_source/home_local_data_source.dart';
import '../../Features/home/domain/use_case/home_use_case/categories_use_case.dart';
import '../../Features/home/domain/use_case/home_use_case/products_Use_Case.dart';
import '../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../Features/layout/presentation/cubit/layout_cubit.dart';
import '../../Features/settings_feature/data/user_data_data_source/user_local_data_source.dart';
import '../../Features/settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../networks/Hive_manager/hive_helper.dart';
import '../networks/Hive_manager/hive_manager.dart';
import '../networks/api_manager/api_helper.dart';
import '../networks/api_manager/api_manager.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() async {
  // Register HiveService
  getIt.registerSingleton<HiveHelper>(HiveManager());

  // Register ApiService
  getIt.registerSingleton<ApiHelper>(
    ApiManager(dio: Dio(), baseUrl: "https://student.valuxapps.com/api/"),
  );

  // Authentication dependencies
  getIt.registerSingleton<AuthenticationRepo>(
    AuthRepoImpl(
      loginDataSource: AuthenticationDataSourceImpl(getIt.get<ApiHelper>()),
    ),
  );
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(authenticationRepo: getIt.get<AuthenticationRepo>()),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(authenticationRepo: getIt.get<AuthenticationRepo>()),
  );

  // Home dependencies
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(apiService: getIt.get<ApiHelper>()),
  );
  getIt.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<UserDataSource>(
    UserDataSourceImpl(
        apiService: getIt.get<ApiHelper>(),
        hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerSingleton<UserLocalDataSourceImpl>(
    UserLocalDataSourceImpl(hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerSingleton<UserLocalDataSource>(
    UserLocalDataSourceImpl(hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerSingleton<UserDataRepo>(
    UserDataRepoImpl(
      getUserDataDataSource: getIt.get<UserDataSource>(),
      userLocalDataSource: getIt.get<UserLocalDataSourceImpl>(),
    ),
  );
  getIt.registerSingleton<CategoriesUseCase>(
    CategoriesUseCase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<UserSignOutUseCase>(
    UserSignOutUseCase(
      getUserDataRepo: getIt.get<UserDataRepo>(),
    ),
  );
  getIt.registerSingleton<UserDataUseCase>(
    UserDataUseCase(
      getUserDataRepo: getIt.get<UserDataRepo>(),
    ),
  );
  getIt.registerSingleton<UpdateUserDataUseCase>(
    UpdateUserDataUseCase(
      getUserDataRepo: getIt.get<UserDataRepo>(),
    ),
  );

  // Favourites dependencies
  getIt.registerSingleton<FavouritesRemoteDataSource>(
    FavouritesRemoteDataSourceImpl(
      apiService: getIt.get<ApiHelper>(),
    ),
  );
  getIt.registerSingleton<FavouritesLocalDataSource>(
    FavouritesLocalDataSourceImpl(hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerSingleton<FavouritesRepo>(
    FavouritesRepoImpl(
      favouritesDataSource: getIt.get<FavouritesRemoteDataSource>(),
      favouritesLocalDataSource: getIt.get<FavouritesLocalDataSource>(),
    ),
  );

  // Search dependencies
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchDataSourceImpl(apiService: getIt.get<ApiHelper>()),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(searchDataSource: getIt.get<SearchRemoteDataSource>()),
  );
  getIt.registerSingleton<SearchUseCase>(
    SearchUseCase(searchRepo: getIt.get<SearchRepo>()),
  );

  // Cart dependencies
  getIt.registerSingleton<CartLocalDataSource>(
    CartLocalDataSourceImpl(hiveService: getIt.get<HiveHelper>()),
  );
  getIt.registerSingleton<CartsRemoteDataSource>(
    CartsRemoteDataSourceImpl(apiService: getIt.get<ApiHelper>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(
      cartLocalDataSource: getIt.get<CartLocalDataSource>(),
      cartsDataSource: getIt.get<CartsRemoteDataSource>(),
    ),
  );

  // Cubits
  getIt.registerFactory(
      () => LoginCubit(loginUseCase: getIt.get<LoginUseCase>()));
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(() => UserDataCubit(
        getUserDataUseCase: getIt.get<UserDataUseCase>(),
        updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
        userSignOutUseCase: getIt.get<UserSignOutUseCase>(),
      ));
  getIt.registerFactory(() => CategoriesCubit(
        fetchCategoriesUseCase: getIt.get<CategoriesUseCase>(),
      ));
  getIt.registerFactory(() => FavouritesCubit(
        getIt.get<GetFavouritesUseCases>(),
        getIt.get<ToggleFavouritesUseCase>(),
      ));
  getIt.registerFactory(() => CartsCubit(
        getIt.get<FetchCartUseCase>(),
        getIt.get<RemoveCartUseCase>(),
        getIt.get<ToggleCartUseCase>(),
      ));

  getIt.registerFactory(() =>
      GetProductsCubit(fetchHomeItemsUseCase: getIt.get<ProductsUseCase>()));
  getIt.registerFactory(() => LayoutCubit());

  // Use Cases
  getIt.registerFactory(
      () => GetFavouritesUseCases(favouritesRepo: getIt.get<FavouritesRepo>()));
  getIt.registerFactory(() => ToggleFavouritesUseCase(
      favouritesRepository: getIt.get<FavouritesRepo>()));
  getIt.registerFactory(
      () => ToggleCartUseCase(cartRepo: getIt.get<CartRepo>()));
  getIt
      .registerFactory(() => FetchCartUseCase(cartRepo: getIt.get<CartRepo>()));
  getIt.registerFactory(
      () => RemoveCartUseCase(cartRepo: getIt.get<CartRepo>()));
  getIt.registerFactory(() => ProductsUseCase(homeRepo: getIt.get<HomeRepo>()));
}
