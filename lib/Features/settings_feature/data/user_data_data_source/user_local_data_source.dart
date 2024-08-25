import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/user_entity/user_entity.dart';

abstract class UserLocalDataSource {
  const UserLocalDataSource();
  Future<void> saveUserData({required UserEntity user});
  Future<UserEntity?> loadUserData();
  Future<void> clearUserData();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final HiveHelper hiveHelper;

  const UserLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    await hiveHelper.saveSingleItem<UserEntity>(
        'user', user, HiveBoxesNames.kUserBox);
    print('User data saved to Hive');
  }

  @override
  Future<UserEntity?> loadUserData() async {
    return await hiveHelper.loadSingleItem<UserEntity>(
        'user', HiveBoxesNames.kUserBox);
  }

  @override
  Future<void> clearUserData() async {
    await hiveHelper.clearSingleItem<UserEntity>(
        'user', HiveBoxesNames.kUserBox);
    print('User data cleared from Hive');
  }
}
