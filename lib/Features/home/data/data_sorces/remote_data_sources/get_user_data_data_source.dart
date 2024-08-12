import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';
import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../../../core/widgets/api_service.dart';

abstract class GetUserDataDataSource {
  Future<UserEntity> getUserData();
  Future<UserEntity> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
  Future<void> saveUserData(UserEntity user);
  Future<UserEntity?> loadUserData();
}

class GetUserDataDataSourceImpl implements GetUserDataDataSource {
  final ApiService apiService;
  static const String boxName = 'userBox';

  GetUserDataDataSourceImpl({required this.apiService});

  @override
  Future<UserEntity> getUserData() async {
    try {
      final response = await apiService.get(
        endPoint: profileEndPoint,
        headers: {
          'Authorization': token,
        },
      );

      final loginModel = LoginModel.fromJson(response);
      final user = UserEntity(
        name: loginModel.name,
        email: loginModel.email,
        phone: loginModel.phone,
        token: loginModel.token,
      );

      // Save to Hive
      await saveUserData(user);

      return user;
    } catch (e) {
      print('Error getting user data: $e');
      // Try loading from Hive if there's an error
      final cachedUser = await loadUserData();
      if (cachedUser != null) {
        return cachedUser;
      } else {
        throw e;
      }
    }
  }

  @override
  Future<UserEntity> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await apiService.put(
        endPoint: updateProfileEndPoint,
        headers: {
          'Authorization': token,
        },
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );

      final loginModel = LoginModel.fromJson(response);
      final user = UserEntity(
        name: loginModel.name,
        email: loginModel.email,
        phone: loginModel.phone,
        token: loginModel.token,
      );

      // Save updated data to Hive
      await saveUserData(user);

      return user;
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }

  @override
  Future<void> saveUserData(UserEntity user) async {
    var box = await Hive.openBox<UserEntity>(boxName);
    await box.put('user', user); // Save user data with a key
    print('User data saved to Hive');
  }

  @override
  Future<UserEntity?> loadUserData() async {
    var box = await Hive.openBox<UserEntity>(boxName);
    return box.get('user');
  }
}
