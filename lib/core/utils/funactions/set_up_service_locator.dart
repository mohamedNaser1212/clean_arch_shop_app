import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/home/data/data_sorces/local_data_sources/home_local_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/get_favourite_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/home_remote_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/login_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/register_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/search_data_source.dart';
import 'package:shop_app/Features/home/data/repos/favourites_repo/favourites_repo.dart';
import 'package:shop_app/Features/home/data/repos/favourites_repo/favourites_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/get_user_repo/get_user_repo.dart';
import 'package:shop_app/Features/home/data/repos/get_user_repo/get_user_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/login_repo/login_repo.dart';
import 'package:shop_app/Features/home/data/repos/login_repo/login_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/search_repo/search_repo.dart';
import 'package:shop_app/Features/home/data/repos/search_repo/search_repo_impl.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/favourites_use_case/fetch_favourites_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/get_user_data_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/login_use_case/login_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/register_use_case/register_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/search_use_case/fetch_search_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/register_cubit/register_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/widgets/api_service.dart';

import '../../../Features/home/data/data_sorces/remote_data_sources/get_user_data_data_source.dart';
import '../../../Features/home/domain/use_case/favourites_use_case/toggle_favourites_use_case.dart';

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

    return ShopCubit(
      fetchProductsUseCase,
      fetchCategoriesUseCase,
      fetchFavouritesUseCase,
      toggleFavouriteUseCase,
    );
  });
}
