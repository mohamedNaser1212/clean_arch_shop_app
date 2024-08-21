import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_data_source/authentication_data_source.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/favourite_remote_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_repo_impl/favourites_repo_impl.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/home/data/repos/home_repo_impl.dart';

import '../../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../../Features/carts_feature/data/carts_repo_impl/carts_repo_impl.dart';
import '../../../Features/carts_feature/domain/carts_repo/cart_repo.dart';
import '../../../Features/carts_feature/domain/carts_use_case/get_cart_use_case.dart';
import '../../../Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../../Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import '../../../Features/search_feature/data/search_data_source/search_remote_data_source.dart';
import '../../../Features/search_feature/data/search_repo_impl/search_repo_Impl.dart';
import '../../../Features/search_feature/domain/search_repo/search_repo.dart';
import '../../../Features/search_feature/domain/search_use_case/fetch_search_use_case.dart';
import '../../../Features/settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/user_data_use_case.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/carts_feature/data/carts_data_sources/carts_remote_data_source.dart';
import '../../Features/carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import '../../Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import '../../Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import '../../Features/home/data/data_sources/home_remote_data_sources/home_remote_data_source.dart';
import '../../Features/home/domain/home_repo/home_repo.dart';
import '../../Features/home/domain/use_case/home_items_use_case/categories_use_case.dart';
import '../../Features/home/domain/use_case/home_items_use_case/products_Use_Case.dart';
import '../../Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import '../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../Features/settings_feature/data/user_data_data_source/user_info_remote_data_source.dart';
import '../../Features/settings_feature/data/user_data_repo_impl/user_data_repo_impl.dart';
import '../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import '../../Features/settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';
import '../networks/Hive_manager/hive_manager.dart';
import '../networks/Hive_manager/hive_service.dart';
import '../networks/api_manager/api_service.dart';
import '../networks/api_manager/api_service_interface.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() async {
  // Register HiveService
  getIt.registerSingleton<HiveService>(HiveManager());

  // Register ApiService
  getIt.registerSingleton<ApiServiceInterface>(
    ApiService(Dio(), "https://student.valuxapps.com/api/"),
  );

  // Authentication dependencies
  getIt.registerSingleton<AuthenticationRepo>(
    AuthRepoImpl(
      loginDataSource: LoginDataSourceImpl(getIt.get<ApiServiceInterface>()),
    ),
  );
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt.get<AuthenticationRepo>()),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt.get<AuthenticationRepo>()),
  );

  // Home dependencies
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(getIt.get<ApiServiceInterface>()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
      hiveService: getIt.get<HiveService>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<UserDataSource>(
    UserDataSourceImpl(apiService: getIt.get<ApiServiceInterface>()),
  );
  getIt.registerSingleton<UserDataRepo>(
    UserDataRepoImpl(
      getUserDataDataSource: getIt.get<UserDataSource>(),
    ),
  );
  getIt.registerSingleton<CategoriesUseCase>(
    CategoriesUseCase(getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<UserDataUseCase>(
    UserDataUseCase(
      getUserDataRepo: getIt.get<UserDataRepo>(),
    ),
  );
  getIt.registerSingleton<UpdateUserDataUseCase>(
    UpdateUserDataUseCase(
      getIt.get<UserDataRepo>(),
    ),
  );

  // Favourites dependencies
  getIt.registerSingleton<FavouritesRemoteDataSource>(
    FavouritesRemoteDataSourceImpl(
      apiService: getIt.get<ApiServiceInterface>(),
    ),
  );
  getIt.registerSingleton<FavouritesRepo>(
    FavouritesRepoImpl(
      hiveService: getIt.get<HiveService>(),
      getFavouritesDataSource: getIt.get<FavouritesRemoteDataSource>(),
    ),
  );

  // Search dependencies
  getIt.registerSingleton<SearchDataSource>(
    SearchDataSourceImpl(getIt.get<ApiServiceInterface>()),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(getIt.get<SearchDataSource>()),
  );
  getIt.registerSingleton<SearchUseCase>(
    SearchUseCase(getIt.get<SearchRepo>()),
  );

  // Add to Cart dependencies
  getIt.registerSingleton<CartsRemoteDataSource>(
    CartsRemoteDataSourceImpl(apiService: getIt.get<ApiServiceInterface>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(
      hiveService: getIt.get<HiveService>(),
      cartsDataSource: getIt.get<CartsRemoteDataSource>(),
    ),
  );

  // Cubits
  getIt.registerFactory(() => LoginCubit(getIt.get<LoginUseCase>()));
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(() => UserDataCubit(
        getUserDataUseCase: getIt.get<UserDataUseCase>(),
        updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
      ));
  getIt.registerFactory(() => CategoriesCubit(
        fetchCategoriesUseCase: getIt.get<CategoriesUseCase>(),
      ));
  // getIt.registerFactory(() => SearchCubit(
  //       fetchSearchUseCase: getIt.get<SearchUseCase>(),
  //     ));
  getIt.registerFactory(() => FavouritesCubit(
        getIt.get<GetFavouritesUseCases>(),
        getIt.get<ToggleFavouritesUseCase>(),
      ));
  getIt.registerFactory(() => CartsCubit(
        getIt.get<FetchCartUseCase>(),
        getIt.get<RemoveCartUseCase>(),
        getIt.get<ToggleCartUseCase>(),
      ));
  getIt.registerFactory(() => GetProductsCubit(
        fetchHomeItemsUseCase: getIt.get<ProductsUseCase>(),
      ));

  getIt.registerFactory(
      () => GetFavouritesUseCases(getIt.get<FavouritesRepo>()));
  getIt.registerFactory(
      () => ToggleFavouritesUseCase(getIt.get<FavouritesRepo>()));
  getIt.registerFactory(() => ToggleCartUseCase(getIt.get<CartRepo>()));
  getIt.registerFactory(() => FetchCartUseCase(getIt.get<CartRepo>()));
  getIt.registerFactory(() => RemoveCartUseCase(getIt.get<CartRepo>()));
  getIt.registerFactory(() => ProductsUseCase(getIt.get<HomeRepo>()));
}
