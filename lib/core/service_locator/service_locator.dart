import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_data_source/authentication_data_source.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/favourite_remote_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_repo_impl/favourites_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';

import '../../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../../Features/carts_feature/data/carts_repo_impl/carts_repo_impl.dart';
import '../../../Features/carts_feature/domain/carts_repo/cart_repo.dart';
import '../../../Features/carts_feature/domain/carts_use_case/carts_use_case.dart';
import '../../../Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../../Features/favourites_feature/domain/favourites_use_case/favourites_use_case.dart';
import '../../../Features/search_feature/data/search_data_source/search_remote_data_source.dart';
import '../../../Features/search_feature/data/search_repo_impl/search_repo_Impl.dart';
import '../../../Features/search_feature/domain/search_repo/search_repo.dart';
import '../../../Features/search_feature/domain/search_use_case/fetch_search_use_case.dart';
import '../../../Features/settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/get_user_data_use_case.dart';
import '../../../Features/settings_feature/presentation/cubit/get_user_info_cubit/get_user_data_cubit.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/authentication_feature/domain/authentication_use_case/authentication_use_case.dart';
import '../../Features/carts_feature/data/carts_data_sources/carts_remote_data_source.dart';
import '../../Features/home/data/data_sources/home_remote_data_sources/home_remote_data_source.dart';
import '../../Features/home/domain/home_repo/home_repo.dart';
import '../../Features/home/domain/use_case/home_items_use_case/Home_Items_Use_Case.dart';
import '../../Features/settings_feature/data/user_data_data_source/user_info_remote_data_source.dart';
import '../../Features/settings_feature/data/user_data_repo_impl/user_data_repo_impl.dart';
import '../utils/screens/widgets/api_service.dart';

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
  getIt.registerSingleton<AuthenticationUseCase>(
    AuthenticationUseCase(getIt.get<LoginRepo>()),
  );

  // Home dependencies
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(getIt.get<ApiService>()),
  );

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<UserDataSource>(
    UserDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SuperGetUserDataRepo>(
    UserDataRepoImpl(
      getUserDataDataSource: getIt.get<UserDataSource>(),
    ),
  );
  getIt.registerSingleton<UserDataUseCase>(
    UserDataUseCase(
      getUserDataRepo: getIt.get<SuperGetUserDataRepo>(),
    ),
  );

  // Favourites dependencies
  getIt.registerSingleton<FavouritesRemoteDataSource>(
    FavouritesRemoteDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<FavouritesRepo>(
    FavouritesRepoImpl(
      getFavouritesDataSource: getIt.get<FavouritesRemoteDataSource>(),
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
  getIt.registerSingleton<CartsRemoteDataSource>(
    CartsRemoteDataSourceImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(getCartsDataSource: getIt.get<CartsRemoteDataSource>()),
  );

  // Cubits
  getIt.registerFactory(() => LoginCubit(getIt.get<AuthenticationUseCase>()));
  getIt
      .registerFactory(() => RegisterCubit(getIt.get<AuthenticationUseCase>()));
  getIt.registerFactory(
      () => UserDataCubit(getUserDataUseCase: getIt.get<UserDataUseCase>()));
  getIt.registerFactory(() {
    final fetchProductsUseCase = HomeItemsUseCase(getIt<HomeRepo>());

    final fetchFavouritesUseCase = FavouritesUseCases(getIt<FavouritesRepo>());
    final fetchCartUseCase = FetchCartUseCase(getIt<CartRepo>());

    return ShopCubit(
      fetchProductsUseCase, fetchFavouritesUseCase,
      fetchCartUseCase,
      // fetchCartUseCase,C
      // removeCartUseCase,
    );
  });
}
