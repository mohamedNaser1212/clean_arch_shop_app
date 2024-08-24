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
  final HiveHelper hiveService;

  const UserLocalDataSourceImpl({required this.hiveService});

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    await hiveService.saveSingleItem<UserEntity>(
        'user', user, HiveBoxesNames.kUserBox);
    print('User data saved to Hive');
  }

  @override
  Future<UserEntity?> loadUserData() async {
    return await hiveService.loadSingleItem<UserEntity>(
        'user', HiveBoxesNames.kUserBox);
  }

  @override
  Future<void> clearUserData() async {
    await hiveService.clearSingleItem<UserEntity>(
        'user', HiveBoxesNames.kUserBox);
    print('User data cleared from Hive');
  }
}
