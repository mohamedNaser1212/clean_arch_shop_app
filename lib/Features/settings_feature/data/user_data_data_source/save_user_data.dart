import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_service.dart';
import '../../domain/user_entity/user_entity.dart';

HiveService? hiveService;
Future<void> saveUserData({
  required UserEntity user,
}) async {
  await hiveService?.saveSingleItem<UserEntity>(
      'user', user, HiveBoxesNames.kUserBox);
  print('User data saved to Hive');
}

Future<UserEntity?> loadUserData() async {
  return await hiveService?.loadSingleItem<UserEntity>(
      'user', HiveBoxesNames.kUserBox);
}

Future<void> clearUserData() async {
  await hiveService?.clearSingleItem<UserEntity>(
      'user', HiveBoxesNames.kUserBox);
  print('User data cleared from Hive');
}
