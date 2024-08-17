import 'package:shop_app/Features/authentication_feature/data/authentication_models/login_model.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../core/widgets/api_service.dart';
import '../../domain/user_entity/user_entity.dart';

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
      ApiRequestModel request = ApiRequestModel(
        endpoint: profileEndPoint,
      );
      final response = await apiService.get(
        request: request,
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
      ApiRequestModel request = ApiRequestModel(
        endpoint: updateProfileEndPoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );

      final response = await apiService.put(
        request: request,
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
