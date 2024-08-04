import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/Features/home/data/data_sorces/get_user_data_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/login_data_source.dart';
import 'package:shop_app/Features/home/data/data_sorces/register_data_source.dart';
import 'package:shop_app/Features/home/data/repos/get_user_repo/get_user_repo.dart';
import 'package:shop_app/Features/home/data/repos/get_user_repo/get_user_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/login_repo/login_repo.dart';
import 'package:shop_app/Features/home/data/repos/login_repo/login_repo_impl.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo_impl.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/get_user_data_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/login_use_case/login_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/register_use_case/register_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/register_cubit/register_cubit.dart';
import 'package:shop_app/core/widgets/dio_helper.dart';

import '../../../Features/home/data/data_sorces/home_remote_data_source.dart';

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

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      HomeRemoteDataSourceImpl(getIt.get<ApiService>()),
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

  // Cubits
  getIt.registerFactory(() => LoginCubit(getIt.get<LoginUseCase>()));
  getIt.registerFactory(() => RegisterCubit(getIt.get<RegisterUseCase>()));
  getIt.registerFactory(() => UserDataCubit(
        getUserDataUseCase: getIt.get<UserDataUseCase>(),
      ));
}
