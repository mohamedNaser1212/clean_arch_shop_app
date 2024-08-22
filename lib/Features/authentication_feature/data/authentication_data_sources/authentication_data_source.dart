import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../authentication_models/authentication_model.dart';

abstract class AuthenticationDataSource {
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

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final ApiManager apiServiceInterface;

  const AuthenticationDataSourceImpl(this.apiServiceInterface);

  @override
  Future<AuthenticationModel> login({
    required String email,
    required String password,
  }) async {
    final headerModel = HeaderModel();

    final request = ApiRequestModel(
      endpoint: EndPoints.loginEndPoint,
      data: {
        RequestDataNames.email: email,
        RequestDataNames.password: password,
      },
      headerModel: headerModel,
    );

    final response = await apiServiceInterface.post(request: request);

    final loginModel = AuthenticationModel.fromJson(response);

    return loginModel;
  }

  @override
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final headerModel = HeaderModel();

    final request = ApiRequestModel(
      endpoint: EndPoints.registerEndPoint,
      data: {
        RequestDataNames.email: email,
        RequestDataNames.password: password,
        RequestDataNames.name: name,
        RequestDataNames.phone: phone,
      },
      headerModel: headerModel,
    );

    final response = await apiServiceInterface.post(request: request);

    final registerModel = AuthenticationModel.fromJson(response);

    return registerModel;
  }
}
