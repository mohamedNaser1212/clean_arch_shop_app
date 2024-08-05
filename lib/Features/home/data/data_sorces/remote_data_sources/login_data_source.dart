import '../../../../../core/widgets/api_service.dart';
import '../../../../../models/api_request_model/api_request_model.dart';
import '../../../../../models/login_model.dart';

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
    final response =
        await apiService.post(endPoint: request.endpoint, data: request.data!);

    loginModel = LoginModel.fromJson(response);
    return loginModel;
  }
}
