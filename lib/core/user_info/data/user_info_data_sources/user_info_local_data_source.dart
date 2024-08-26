import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../../networks/Hive_manager/hive_boxes_names.dart';
import '../../../networks/Hive_manager/hive_helper.dart';

abstract class UserInfoLocalDataSource {
  const UserInfoLocalDataSource();
  Future<void> saveUserData({required UserEntity user});
  Future<UserEntity?> loadUserData();
  Future<void> clearUserData();
}

class UserLocalDataSourceImpl implements UserInfoLocalDataSource {
  final LocalStorageHelper hiveHelper;

  const UserLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    await hiveHelper.saveSingleItem<UserEntity>(
        HiveBoxesNames.kUserBox, user, HiveBoxesNames.kUserBox);
    print('User data saved to Hive');
  }

  @override
  Future<UserEntity?> loadUserData() async {
    return await hiveHelper.loadSingleItem<UserEntity>(
        HiveBoxesNames.kUserBox, HiveBoxesNames.kUserBox);
  }

  @override
  Future<void> clearUserData() async {
    await hiveHelper.clearSingleItem<UserEntity>(
        HiveBoxesNames.kUserBox, HiveBoxesNames.kUserBox);
    print('User data cleared from Hive');
  }
}
