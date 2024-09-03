import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_local_data_source.dart';
import 'package:shop_app/Features/home/data/data_sources/home_local_data_source/home_local_data_source.dart';
import 'package:shop_app/Features/settings_feature/data/user_data_data_source/user_remote_remote_data_source.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/networks/api_manager/api_manager.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../../core/user_info/data/user_info_data_sources/user_info_remote_data_source.dart';
import '../../../favourites_feature/data/favourite_data_source/favourites_local_data_source.dart';
import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserInfoRemoteDataSource getUserInfoDataSource;
  final UserRemoteDataSource getUserDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  final RepoManager repoManager;
  const UserDataRepoImpl({
    required this.getUserInfoDataSource,
    required this.userInfoLocalDataSource,
    required this.getUserDataSource,
    required this.cartLocalDataSource,
    required this.favouritesLocalDataSource,
    required this.homeLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    return repoManager.call(
      action: () async {
        final cachedUserData = await userInfoLocalDataSource.loadUserData();

        if (cachedUserData != null) {
          return cachedUserData;
        } else {
          final userData = await getUserInfoDataSource.getUser();
          await userInfoLocalDataSource.saveUserData(user: userData);
          return userData;
        }
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    return repoManager.call(
      action: () async {
        final userData = await getUserDataSource.updateUserData(
            name: name, email: email, phone: phone);
        await userInfoLocalDataSource.saveUserData(user: userData);
        return userData;
      },
    );
  }

  @override
  Future<Either<Failure, bool>> signOut({
    required ApiManager apiService,
  }) async {
    return repoManager.call(
      action: () async {
        final result = await getUserDataSource.signOut(
          apiService: apiService,
        );

        if (result) {
          await cartLocalDataSource.clearCart();

          await favouritesLocalDataSource.clearFavourites();

          await userInfoLocalDataSource.clearUserData();
          await homeLocalDataSource.clearProducts();
        }

        return result;
      },
    );
  }
}
