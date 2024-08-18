import '../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../core/utils/screens/widgets/api_service.dart';
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
  ApiService apiService;
  LoginDataSourceImpl(this.apiService);
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
    final response = await apiService.post(request: request);

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
    final response = await apiService.post(request: request);

    loginModel = AuthenticationModel.fromJson(response);
    return loginModel;
  }
}
