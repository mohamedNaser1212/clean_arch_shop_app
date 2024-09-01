import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_local_data_source.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_remote_data_source.dart';
import 'package:shop_app/Features/carts_feature/data/carts_repo_impl/carts_repo_impl.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_repo/cart_repo.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/fetch_cart_use_case.dart';
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
import 'package:shop_app/Features/home/domain/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/search_feature/data/search_data_source/search_remote_data_source.dart';
import 'package:shop_app/Features/search_feature/data/search_repo_impl/search_repo_impl.dart';
import 'package:shop_app/Features/search_feature/domain/search_repo/search_repo.dart';
import 'package:shop_app/Features/search_feature/domain/search_use_case/fetch_search_use_case.dart';
import 'package:shop_app/Features/settings_feature/data/user_data_data_source/user_remote_remote_data_source.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/update_user_data_use_case.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager_impl.dart';

import '../../Features/authentication_feature/data/authentication_data_sources/authentication_remote_data_source.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../Features/home/data/data_sources/home_local_data_source/home_local_data_source.dart';
import '../../Features/home/data/repo/home_repo_impl.dart';
import '../../Features/home/domain/use_case/home_use_case/categories_use_case.dart';
import '../../Features/home/domain/use_case/home_use_case/products_Use_Case.dart';
import '../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../Features/settings_feature/data/user_data_repo_impl/user_data_repo_impl.dart';
import '../../Features/settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../Features/settings_feature/domain/settings_use_case/user_sign_out_use_case.dart';
import '../managers/internet_manager/internet_manager.dart';
import '../managers/internet_manager/internet_manager_impl.dart';
import '../managers/repo_manager/repo_manager.dart';
import '../networks/Hive_manager/hive_helper.dart';
import '../networks/Hive_manager/hive_manager.dart';
import '../networks/api_manager/api_helper.dart';
import '../networks/api_manager/api_manager.dart';
import '../payment_gate_way_manager/cubit/payment_cubit.dart';
import '../payment_gate_way_manager/data/payment_data_source/payment_data_source.dart';
import '../payment_gate_way_manager/data/payment_repo_impl/payment_repo_impl.dart';
import '../payment_gate_way_manager/domain/payment_repo/payment_repo.dart';
import '../payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';
import '../user_info/cubit/user_info_cubit.dart';
import '../user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import '../user_info/data/user_info_data_sources/user_info_remote_data_source.dart';
import '../user_info/data/user_info_repo_impl/user_info_repo_impl.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';
import '../user_info/domain/user_info_repo/user_info_repo.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() async {
  //register UserInfoRepo
  getIt.registerSingleton<ApiManager>(
    DioManager(dio: Dio(), baseUrl: "https://student.valuxapps.com/api/"),
  );
  getIt.registerSingleton<InternetManager>(InternetManagerImpl());

  // Register HiveService
  getIt.registerSingleton<LocalStorageManager>(HiveManager());
  await getIt.get<LocalStorageManager>().initialize();
  print("Hive Initialized");

  getIt.registerSingleton<RepoManager>(
    RepoManagerImpl(
      getIt.get<InternetManager>(),
    ),
  );
  getIt.registerSingleton<UserInfoLocalDataSource>(
    UserLocalDataSourceImpl(hiveHelper: getIt.get<LocalStorageManager>()),
  );
  getIt.registerFactory(() => UserInfoCubit(
        getUserUseCase: getIt.get<GetUserInfoUseCase>(),
      ));

  getIt.registerSingleton<UserInfoRemoteDataSource>(
    UserInfoRemoteDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );

  getIt.registerSingleton<UserInfoRepo>(
    UserInfoRepoImpl(
      remoteDataSource: getIt.get<UserInfoRemoteDataSource>(),
      userLocalDataSource: getIt.get<UserInfoLocalDataSource>(),
      internetManager: getIt.get<InternetManager>(),
    ),
  );

  getIt.registerSingleton<GetUserInfoUseCase>(
    GetUserInfoUseCase(userInfoRepo: getIt.get<UserInfoRepo>()),
  );

  // Register ApiService

  // Register HomeLocalDataSource
  getIt.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(hiveHelper: getIt.get<LocalStorageManager>()),
  );

  // Authentication dependencies

  getIt.registerSingleton<AuthenticationRepo>(
    AuthRepoImpl(
      loginDataSource:
          AuthenticationDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
      userInfoLocalDataSourceImpl: getIt.get<UserInfoLocalDataSource>(),
      repoManager: getIt.get<RepoManager>(),
    ),
  );

  // Register UseCases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(authenticationRepo: getIt.get<AuthenticationRepo>()),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(authenticationRepo: getIt.get<AuthenticationRepo>()),
  );

  // Home dependencies
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
      repoManager: getIt.get<RepoManager>(),
    ),
  );

  // User Data dependencies
  getIt.registerSingleton<UserRemoteDataSource>(
    UserDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );
  getIt.registerSingleton<CartLocalDataSource>(
    CartLocalDataSourceImpl(hiveHelper: getIt.get<LocalStorageManager>()),
  );
  getIt.registerSingleton<FavouritesLocalDataSource>(
    FavouritesLocalDataSourceImpl(hiveHelper: getIt.get<LocalStorageManager>()),
  );
  getIt.registerSingleton<CartsRemoteDataSource>(
    CartsRemoteDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );
  // Register CartRepo
  getIt.registerSingleton<CartRepo>(
    CartsRepoImpl(
      cartLocalDataSource: getIt.get<CartLocalDataSource>(),
      cartsRemoteDataSource: getIt.get<CartsRemoteDataSource>(),
      repoManager: getIt.get<RepoManager>(),
    ),
  );
  getIt.registerSingleton<UserDataRepo>(
    UserDataRepoImpl(
      getUserDataSource: getIt.get<UserRemoteDataSource>(),
      userInfoLocalDataSource: getIt.get<UserInfoLocalDataSource>(),
      getUserInfoDataSource: getIt.get<UserInfoRemoteDataSource>(),
      cartLocalDataSource: getIt.get<CartLocalDataSource>(),
      favouritesLocalDataSource: getIt.get<FavouritesLocalDataSource>(),
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
      repoManager: getIt.get<RepoManager>(),
    ),
  );

  getIt.registerSingleton<FetchCartUseCase>(
      FetchCartUseCase(cartRepo: getIt.get<CartRepo>()));
  getIt.registerSingleton<ToggleCartUseCase>(
      ToggleCartUseCase(cartRepo: getIt.get<CartRepo>()));
  getIt.registerSingleton<RemoveCartUseCase>(
      RemoveCartUseCase(cartRepo: getIt.get<CartRepo>()));

  getIt.registerSingleton<CategoriesUseCase>(
    CategoriesUseCase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<ProductsUseCase>(
    ProductsUseCase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<UserSignOutUseCase>(
    UserSignOutUseCase(getUserDataRepo: getIt.get<UserDataRepo>()),
  );

  getIt.registerSingleton<UpdateUserDataUseCase>(
    UpdateUserDataUseCase(getUserDataRepo: getIt.get<UserDataRepo>()),
  );

  // Favourites dependencies
  getIt.registerSingleton<FavouritesRemoteDataSource>(
    FavouritesRemoteDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );

  getIt.registerSingleton<FavouritesRepo>(
    FavouritesRepoImpl(
      favouritesDataSource: getIt.get<FavouritesRemoteDataSource>(),
      favouritesLocalDataSource: getIt.get<FavouritesLocalDataSource>(),
      repoManager: getIt.get<RepoManager>(),
    ),
  );

  // Search dependencies
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchDataSourceImpl(apiHelper: getIt.get<ApiManager>()),
  );

  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(
        searchDataSource: getIt.get<SearchRemoteDataSource>(),
        repoManager: getIt.get<RepoManager>()),
  );

  getIt.registerSingleton<SearchUseCase>(
    SearchUseCase(searchRepo: getIt.get<SearchRepo>()),
  );

  getIt.registerSingleton<PaymentDataSource>(
    PaymentPaymentDataSourceImpl(),
  );

  // Register PaymentRepo
  getIt.registerSingleton<PaymentRepo>(
    PaymentRepoImpl(
      paymentManager: getIt.get<PaymentDataSource>(),
      internetManager: getIt.get<InternetManager>(),
    ),
  );

  // Register PaymentUseCase
  getIt.registerSingleton<PaymentUseCase>(
    PaymentUseCase(paymentRepo: getIt.get<PaymentRepo>()),
  );

  // Register PaymentCubit
  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      paymentUseCase: getIt.get<PaymentUseCase>(),
    ),
  );
  // Cubits

  getIt.registerFactory(
    () => LoginCubit(
      loginUseCase: getIt.get<LoginUseCase>(),
      userDataUseCase: getIt.get<GetUserInfoUseCase>(),
    ),
  );
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(() => UserDataCubit(
        getInfoUserDataUseCase: getIt.get<GetUserInfoUseCase>(),
        userSignOutUseCase: getIt.get<UserSignOutUseCase>(),
        updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
      ));
  getIt.registerFactory(() => CartsCubit(
        fetchCartUseCase: FetchCartUseCase(cartRepo: getIt.get<CartRepo>()),
        toggleCartUseCase: ToggleCartUseCase(cartRepo: getIt.get<CartRepo>()),
        removeCartUseCase: RemoveCartUseCase(cartRepo: getIt.get<CartRepo>()),
      ));
  getIt.registerFactory(() => ProductsCubit(
        fetchHomeItemsUseCase: getIt.get<ProductsUseCase>(),
      ));
  getIt.registerFactory(() => CategoriesCubit(
        fetchCategoriesUseCase: getIt.get<CategoriesUseCase>(),
      ));

  getIt.registerFactory(() => FavouritesCubit(
        toggleFavouritesUseCase: ToggleFavouritesUseCase(
            favouritesRepository: getIt.get<FavouritesRepo>()),
        fetchFavouritesUseCase:
            GetFavouritesUseCases(favouritesRepo: getIt.get<FavouritesRepo>()),
      ));
}
