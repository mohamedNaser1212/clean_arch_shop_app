import '../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../core/widgets/api_service.dart';
import '../authentication_models/login_model.dart';

abstract class LoginDataSource {
  Future<LoginModel> login({required String email, required String password});
}

class LoginDataSourceImpl implements LoginDataSource {
  ApiService apiService;
  LoginDataSourceImpl(this.apiService);
  @override
  login({required String email, required String password}) async {
    LoginModel loginModel;
    ApiRequestModel request = ApiRequestModel(
      endpoint: 'login',
      data: {
        'email': email,
        'password': password,
      },
    );
    final response = await apiService.post(request: request);

    loginModel = LoginModel.fromJson(response);
    return loginModel;
  }
}
