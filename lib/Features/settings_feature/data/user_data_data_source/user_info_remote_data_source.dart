import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/utils/dio_data_name.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../../../../core/utils/widgets/token_storage_helper.dart';

abstract class UserDataSource {
  Future<AuthenticationModel> getUserData();
  Future<AuthenticationModel> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
}

class UserDataSourceImpl implements UserDataSource {
  final ApiServiceInterface apiService;

  UserDataSourceImpl({required this.apiService});
  final token = HiveHelper.getToken();
  @override
  Future<AuthenticationModel> getUserData() async {
    try {
      ApiRequestModel request = ApiRequestModel(
          endpoint: EndPoints.profileEndPoint,
          headerModel: HeaderModel(authorization: token));
      final response = await apiService.get(
        request: request,
      );

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
            DioDataName.name: name,
            DioDataName.email: email,
            DioDataName.phone: phone,
          },
          headerModel: HeaderModel(authorization: token));

      final response = await apiService.put(
        request: request,
      );

      final loginModel = AuthenticationModel.fromJson(response);
      return loginModel;
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }
}
