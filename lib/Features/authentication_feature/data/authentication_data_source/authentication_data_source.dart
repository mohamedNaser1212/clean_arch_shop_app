import 'package:shop_app/core/utils/api_services/api_service_interface.dart';

import '../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../authentication_models/authentication_model.dart';

abstract class LoginDataSource {
  Future<AuthenticationModel> login(
      {required String email, required String password});
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class LoginDataSourceImpl implements LoginDataSource {
  ApiServiceInterface apiServiceInterface;
  LoginDataSourceImpl(this.apiServiceInterface);
  @override
  Future<AuthenticationModel> login(
      {required String email, required String password}) async {
    AuthenticationModel loginModel;
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.loginEndPoint,
      data: {
        'email': email,
        'password': password,
      },
    );
    final response = await apiServiceInterface.post(request: request);

    loginModel = AuthenticationModel.fromJson(response);
    return loginModel;
  }

  @override
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    AuthenticationModel loginModel;
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.registerEndPoint,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    );
    final response = await apiServiceInterface.post(request: request);

    loginModel = AuthenticationModel.fromJson(response);
    return loginModel;
  }
}
