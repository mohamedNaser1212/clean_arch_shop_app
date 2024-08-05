import '../../../../../core/widgets/api_service.dart';
import '../../../../../models/api_request_model/api_request_model.dart';
import '../../../../../models/login_model.dart';

abstract class RegisterDataSource {
  Future<LoginModel> Register({
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
  Register({
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
    final response =
        await apiService.post(endPoint: request.endpoint, data: request.data!);

    loginModel = LoginModel.fromJson(response);
    return loginModel;
  }
}
