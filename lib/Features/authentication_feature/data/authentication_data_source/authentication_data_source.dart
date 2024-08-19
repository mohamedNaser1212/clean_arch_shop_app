import 'package:shop_app/core/utils/api_services/api_service_interface.dart';

import '../../../../core/models/api_request_model/api_request_model.dart';
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
  login({required String email, required String password}) async {
    AuthenticationModel loginModel;
    ApiRequestModel request = ApiRequestModel(
      endpoint: 'login',
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
  register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    AuthenticationModel loginModel;
    ApiRequestModel request = ApiRequestModel(
      endpoint: 'register',
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
