import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/utils/dio_data_name.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../authentication_models/authentication_model.dart';

abstract class LoginDataSource {
  Future<AuthenticationModel> login({
    required String email,
    required String password,
  });
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class LoginDataSourceImpl implements LoginDataSource {
  final ApiServiceInterface apiServiceInterface;
  String token = ''; // To be set after login

  LoginDataSourceImpl(this.apiServiceInterface);

  @override
  Future<AuthenticationModel> login({
    required String email,
    required String password,
  }) async {
    // Create a HeaderModel with an empty token
    final headerModel = HeaderModel(authorization: token);

    // Define the request with the initial token
    final request = ApiRequestModel(
      endpoint: EndPoints.loginEndPoint,
      data: {
        DioDataName.email: email,
        DioDataName.password: password,
      },
      headerModel: headerModel,
    );

    final response = await apiServiceInterface.post(request: request);

    // Parse the login model from response
    final loginModel = AuthenticationModel.fromJson(response);

    // Update the token if it is present in the response
    token = loginModel.data?.token ?? '';

    return loginModel;
  }

  @override
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    // Create a HeaderModel without a token for registration
    final headerModel = HeaderModel(authorization: token);

    // Define the request for registration
    final request = ApiRequestModel(
      endpoint: EndPoints.registerEndPoint,
      data: {
        DioDataName.email: email,
        DioDataName.password: password,
        DioDataName.name: name,
        DioDataName.phone: phone,
      },
      headerModel: headerModel,
    );

    final response = await apiServiceInterface.post(request: request);

    final registerModel = AuthenticationModel.fromJson(response);
    token = registerModel.data?.token ?? '';
    return registerModel;
  }
}
