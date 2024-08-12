import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../../../core/widgets/api_service.dart';
import '../../../../../core/widgets/constants.dart';

abstract class GetUserDataDataSource {
  Future<UserEntity> getUserData();
  Future<UserEntity> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
}

class GetUserDataDataSourceImpl implements GetUserDataDataSource {
  final ApiService apiService;

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
      return UserEntity(
        name: loginModel.name,
        email: loginModel.email,
        phone: loginModel.phone,
        token: loginModel.token,
      );
    } catch (e) {
      print('Error getting user data: $e');
      throw e;
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
      return UserEntity(
        name: loginModel.name,
        email: loginModel.email,
        phone: loginModel.phone,
        token: loginModel.token,
      );
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }
}
