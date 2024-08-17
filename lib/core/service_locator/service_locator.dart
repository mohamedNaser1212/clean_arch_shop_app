import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_data_source/login_data_source.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/login_repo_impl.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/register_repo_impl.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/get_favourite_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_repo_impl/favourites_repo_impl.dart';
import 'package:shop_app/Features/home/data/data_sorces/local_data_sources/home_local_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/home_remote_data_source.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/settings_feature/data/user_info_repo_impl/get_user_repo_impl.dart';
import 'package:shop_app/core/widgets/api_service.dart';

import '../../../Features/authentication_feature/data/authentication_data_source/register_data_source.dart';
import '../../../Features/authentication_feature/domain/authentication_repo/login_repo/login_repo.dart';
import '../../../Features/authentication_feature/domain/authentication_repo/register_repo/register_repo.dart';
import '../../../Features/authentication_feature/domain/login_use_case/login_use_case.dart';
import '../../../Features/authentication_feature/domain/register_use_case/register_use_case.dart';
import '../../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../../Features/carts_feature/data/carts_data_source/get_carts_data_source.dart';
import '../../../Features/carts_feature/data/carts_repo_impl/carts_repo_impl.dart';
import '../../../Features/carts_feature/domain/carts_repo/cart_repo.dart';
import '../../../Features/carts_feature/domain/carts_use_case/fetch_cart_use_case.dart';
import '../../../Features/carts_feature/domain/carts_use_case/remove_from_cart.dart';
import '../../../Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import '../../../Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../../Features/favourites_feature/domain/favourites_use_case/fetch_favourites_use_case.dart';
import '../../../Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import '../../../Features/search_feature/data/search_data_source/search_data_source.dart';
import '../../../Features/search_feature/data/search_repo_impl/search_repo_Impl.dart';
import '../../../Features/search_feature/domain/search_repo/search_repo.dart';
import '../../../Features/search_feature/domain/search_use_case/fetch_search_use_case.dart';
import '../../../Features/settings_feature/data/user_info_data_source/user_info_data_source.dart';
import '../../../Features/settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/get_user_data_use_case.dart';
import '../../../Features/settings_feature/presentation/cubit/get_user_info_cubit/get_user_data_cubit.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  // ApiService
  getIt.registerSingleton<ApiService>(
    ApiService(Dio(), "https://student.valuxapps.com/api/"),
  );

  // Login dependencies
  getIt.registerSingleton<LoginRepo>(
    LoginRepoImpl(
      loginDataSource: LoginDataSourceImpl(getIt.get<ApiService>()),
    ),
  );
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt.get<LoginRepo>()),
  );

  // Register dependencies
  getIt.registerSingleton<RegisterRepo>(
    RegisterRepoImpl(
      registerDataSource: RegisterDataSourceImpl(getIt.get<ApiService>()),
    ),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt.get<RegisterRepo>()),
  );

  // Home dependencies
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<GetUserDataDataSource>(
    GetUserDataDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SuperGetUserDataRepo>(
    GetUserDataRepoImpl(
      getUserDataDataSource: getIt.get<GetUserDataDataSource>(),
    ),
  );
  getIt.registerSingleton<UserDataUseCase>(
    UserDataUseCase(
      getUserDataRepo: getIt.get<SuperGetUserDataRepo>(),
    ),
  );

  // Favourites dependencies
  getIt.registerSingleton<GetFavouritesDataSource>(
    GetFavouritesDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<FavouritesRepo>(
    FavouritesRepoImpl(
      getFavouritesDataSource: getIt.get<GetFavouritesDataSource>(),
    ),
  );

  // Search dependencies
  getIt.registerSingleton<SearchDataSource>(
    SearchDataSourceImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(getIt.get<SearchDataSource>()),
  );
  getIt.registerSingleton<FetchSearchUseCase>(
    FetchSearchUseCase(getIt.get<SearchRepo>()),
  );

  // Add to Cart dependencies
  getIt.registerSingleton<GetCartsDataSource>(
    GetCartsDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(getCartsDataSource: getIt.get<GetCartsDataSource>()),
  );

  // Cubits
  getIt.registerFactory(() => LoginCubit(getIt.get<LoginUseCase>()));
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(
      () => UserDataCubit(getUserDataUseCase: getIt.get<UserDataUseCase>()));
  getIt.registerFactory(() {
    final fetchProductsUseCase = FetchProductsUseCase(getIt<HomeRepo>());
    final fetchCategoriesUseCase = FetchCategoriesUseCase(getIt<HomeRepo>());
    final fetchFavouritesUseCase =
        FetchFavouritesUseCase(getIt<FavouritesRepo>());
    final toggleFavouriteUseCase =
        ToggleFavouriteUseCase(getIt<FavouritesRepo>());
    final fetchCartUseCase = FetchCartUseCase(getIt<CartRepo>());

    final toggleCartUseCase = ToggleCartUseCase(
      cartRepo: getIt<CartRepo>(),
    );

    final removeCartUseCase = RemoveFromCart(
      getIt<CartRepo>(),
    );

    return ShopCubit(
      fetchProductsUseCase,
      fetchCategoriesUseCase,
      fetchFavouritesUseCase,
      toggleFavouriteUseCase,
      toggleCartUseCase,
      fetchCartUseCase,
      removeCartUseCase,
    );
  });
}
