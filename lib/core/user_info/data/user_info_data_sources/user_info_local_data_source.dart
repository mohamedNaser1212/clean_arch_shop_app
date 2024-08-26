import '../../../networks/Hive_manager/hive_boxes_names.dart';
import '../../../networks/Hive_manager/hive_helper.dart';

abstract class UserInfoLocalDataSource {
  const UserInfoLocalDataSource();

  Future<String?> getUserToken();
  Future<void> saveToken({
    required String token,
  });

  Future<void> clearUserData();
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  final LocalStorageHelper hiveHelper;

  UserInfoLocalDataSourceImpl({
    required this.hiveHelper,
  });

  @override
  Future<String?> getUserToken() async {
    try {
      final token = await hiveHelper.loadSingleItem<String>(
          'token', HiveBoxesNames.kSaveTokenBox);
      print('Token retrieved: $token');
      return token;
    } catch (e) {
      print('Error retrieving token: $e');
      return null;
    }
  }

  @override
  Future<void> saveToken({required String token}) async {
    try {
      await hiveHelper.saveSingleItem<String>(
        'token',
        token,
        HiveBoxesNames.kSaveTokenBox,
      );
      print('Token saved: $token');
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  @override
  Future<void> clearUserData() async {
    try {
      hiveHelper.clearSingleItem<String>(
        'token',
        HiveBoxesNames.kSaveTokenBox,
      );
      print('Token cleared');
    } catch (e) {
      print('Error clearing token: $e');
    }
  }
}
