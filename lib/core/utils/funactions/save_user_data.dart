import 'package:hive/hive.dart';

import '../../../Features/home/domain/entities/user_entity/user_entity.dart';

Future<void> saveUserData(UserEntity user) async {
  var box = await Hive.openBox<UserEntity>('userBox');
  await box.put('user', user);
  print('User data saved to Hive');
}

Future<UserEntity?> loadUserData() async {
  var box = await Hive.openBox<UserEntity>('userBox');
  return box.get('user');
}

Future<void> clearUserData() async {
  var box = await Hive.openBox<UserEntity>('userBox');
  await box.delete('user'); // Clear user data
  print('User data cleared from Hive');
}
