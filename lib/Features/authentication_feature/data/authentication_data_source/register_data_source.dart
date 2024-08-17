import '../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../core/widgets/api_service.dart';
import '../authentication_models/login_model.dart';

abstract class RegisterDataSource {
  Future<LoginModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class RegisterDataSourceImpl implements RegisterDataSource {
  ApiService apiService;
  RegisterDataSourceImpl(this.apiService);
  @override
  register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    LoginModel loginModel;
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

    loginModel = LoginModel.fromJson(response);
    return loginModel;
  }
}
