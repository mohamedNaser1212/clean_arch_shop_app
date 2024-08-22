import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

import '../../../../core/networks/Hive_manager/hive_service.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';

abstract class UserDataSource {
  Future<AuthenticationModel> getUserData();
  Future<AuthenticationModel> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
  Future<bool> signOut(
      {required BuildContext context, required ApiManager apiService});
}

class UserDataSourceImpl implements UserDataSource {
  final ApiManager apiService;
  final HiveHelper hiveService;

  const UserDataSourceImpl(
      {required this.apiService, required this.hiveService});

  @override
  Future<AuthenticationModel> getUserData() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.profileEndPoint,
        headerModel: HeaderModel(),
      );
      final response = await apiService.get(request: request);

      final loginModel = AuthenticationModel.fromJson(response);
      return loginModel;
    } catch (e) {
      print('Error getting user data: $e');
      throw e;
    }
  }

  @override
  Future<AuthenticationModel> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.updateProfileEndPoint,
        data: {
          RequestDataNames.name: name,
          RequestDataNames.email: email,
          RequestDataNames.phone: phone,
        },
        headerModel: HeaderModel(),
      );

      final response = await apiService.put(request: request);

      final loginModel = AuthenticationModel.fromJson(response);
      return loginModel;
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }

  @override
  Future<bool> signOut(
      {required BuildContext context, required ApiManager apiService}) async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.logOutEndPoint, headerModel: HeaderModel());
    final response = await apiService.post(request: request);

    return response['status'];
  }
}
