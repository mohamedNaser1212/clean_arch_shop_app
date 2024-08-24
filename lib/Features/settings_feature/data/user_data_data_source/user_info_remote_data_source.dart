import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';

abstract class UserDataSource {
  const UserDataSource();
  Future<AuthenticationModel> getUserData();
  Future<AuthenticationModel> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
  Future<bool> signOut(
      {required BuildContext context, required ApiHelper apiService});
}

class UserDataSourceImpl implements UserDataSource {
  final ApiHelper apiService;
  final HiveHelper hiveService;

  const UserDataSourceImpl(
      {required this.apiService, required this.hiveService});

  @override
  Future<AuthenticationModel> getUserData() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.profileEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiService.get(request: request);

    final loginModel = AuthenticationModel.fromJson(response);
    return loginModel;
  }

  @override
  Future<AuthenticationModel> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
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
  }

  @override
  Future<bool> signOut(
      {required BuildContext context, required ApiHelper apiService}) async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.logOutEndPoint, headerModel: HeaderModel());
    final response = await apiService.post(request: request);

    return response['status'];
  }
}
