// Assuming you have a way to get the HiveService instance, such as from a service locator.
import 'package:shop_app/core/models/hive_manager/hive_service.dart'; // Import HiveService

import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../domain/user_entity/user_entity.dart';

HiveService? hiveService;

Future<void> saveUserData(UserEntity user) async {
  await hiveService?.saveSingleItem<UserEntity>('user', user, kUserBox);
  print('User data saved to Hive');
}

Future<UserEntity?> loadUserData() async {
  return await hiveService?.loadSingleItem<UserEntity>('user', kUserBox);
}

Future<void> clearUserData() async {
  await hiveService?.clearSingleItem<UserEntity>('user', kUserBox);
  print('User data cleared from Hive');
}
