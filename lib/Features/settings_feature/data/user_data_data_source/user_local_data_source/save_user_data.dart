import 'package:shop_app/core/utils/screens/widgets/end_points.dart';

import '../../../../../core/models/hive_manager/hive_manager.dart';
import '../../../domain/user_entity/user_entity.dart';

Future<void> saveUserData(UserEntity user) async {
  await HiveManager.saveSingleItem<UserEntity>('user', user, kUserBox);
  print('User data saved to Hive');
}

Future<UserEntity?> loadUserData() async {
  return await HiveManager.loadSingleItem<UserEntity>('user', kUserBox);
}

Future<void> clearUserData() async {
  await HiveManager.clearSingleItem<UserEntity>('user', kUserBox);
  print('User data cleared from Hive');
}
