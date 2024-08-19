import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_data_source/authentication_data_source.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/favourites_feature/data/favourite_data_source/favourite_remote_data_source.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_repo_impl/favourites_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/models/hive_manager/hive_service.dart'; // Import HiveService
import 'package:shop_app/core/utils/api_services/api_service_interface.dart';

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
import '../../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/get_user_data_use_case.dart';
import '../../../Features/settings_feature/presentation/cubit/get_user_info_cubit/get_user_data_cubit.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/carts_feature/data/carts_data_sources/carts_remote_data_source.dart';
import '../../Features/carts_feature/domain/carts_use_case/remove_cart_use_case.dart';
import '../../Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';
import '../../Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import '../../Features/home/data/data_sources/home_remote_data_sources/home_remote_data_source.dart';
import '../../Features/home/domain/home_repo/home_repo.dart';
import '../../Features/home/domain/use_case/home_items_use_case/categories_use_case.dart';
import '../../Features/home/domain/use_case/home_items_use_case/products_Use_Case.dart';
import '../../Features/settings_feature/data/user_data_data_source/user_info_remote_data_source.dart';
import '../../Features/settings_feature/data/user_data_repo_impl/user_data_repo_impl.dart';
import '../../Features/settings_feature/domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import '../models/hive_manager/hive_manager.dart';
import '../utils/api_services/api_service.dart';

// ...other imports...

final getIt = GetIt.instance;

void setUpServiceLocator() async {
  //registering the HiveService
  getIt.registerSingleton<HiveService>(HiveManager());

  // Register ApiService
  getIt.registerSingleton<ApiServiceInterface>(
    ApiService(Dio(), "https://student.valuxapps.com/api/"),
  );

  getIt.registerSingleton<AuthenticationRepo>(
    LoginRepoImpl(
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
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
      hiveService: getIt.get<HiveService>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<UserDataSource>(
    UserDataSourceImpl(apiService: getIt.get<ApiServiceInterface>()),
  );
  getIt.registerSingleton<SuperGetUserDataRepo>(
    UserDataRepoImpl(
      getUserDataDataSource: getIt.get<UserDataSource>(),
    ),
  );
  getIt.registerSingleton<GetUserDataUseCase>(
    GetUserDataUseCase(
      getUserDataRepo: getIt.get<SuperGetUserDataRepo>(),
    ),
  );
  getIt.registerSingleton<UpdateUserDataUseCase>(
    UpdateUserDataUseCase(
      getIt.get<SuperGetUserDataRepo>(),
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
  getIt.registerSingleton<FetchSearchUseCase>(
    FetchSearchUseCase(getIt.get<SearchRepo>()),
  );

  // Add to Cart dependencies
  getIt.registerSingleton<CartsRemoteDataSource>(
    CartsRemoteDataSourceImpl(apiService: getIt.get<ApiServiceInterface>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(
      getCartsDataSource: getIt.get<CartsRemoteDataSource>(),
      // hiveService: getIt.get<HiveService>(),
    ),
  );

  // Cubits
  getIt.registerFactory(() => LoginCubit(getIt.get<LoginUseCase>()));
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(() => UserDataCubit(
        getUserDataUseCase: getIt.get<GetUserDataUseCase>(),
        updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
      ));
  getIt.registerFactory(() {
    final fetchProductsUseCase = productsUseCase(getIt<HomeRepo>());
    final fetchFavouritesUseCase =
        GetFavouritesUseCases(getIt<FavouritesRepo>());
    final fetchCartUseCase = FetchCartUseCase(getIt<CartRepo>());
    final removeCartUseCase = RemoveCartUseCase(getIt<CartRepo>());
    final toggleCartUseCase = ToggleCartUseCase(getIt<CartRepo>());
    final toggleFavouritesUseCase =
        ToggleFavouritesUseCase(getIt<FavouritesRepo>());
    final fetchCategoriesUseCase = CategoriesUseCase(getIt<HomeRepo>());

    return ShopCubit(
      fetchProductsUseCase,
      fetchFavouritesUseCase,
      fetchCartUseCase,
      removeCartUseCase,
      toggleCartUseCase,
      toggleFavouritesUseCase,
      fetchCategoriesUseCase,
    );
  });
}
