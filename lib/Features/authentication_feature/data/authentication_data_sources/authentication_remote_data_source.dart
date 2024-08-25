import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../authentication_models/authentication_model.dart';

abstract class AuthenticationRemoteDataSource {
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

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  final ApiHelper apiHelper;

  const AuthenticationDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<AuthenticationModel> login({
    required String email,
    required String password,
  }) async {
    final request = ApiRequestModel(
      endpoint: EndPoints.loginEndPoint,
      data: {
        RequestDataNames.email: email,
        RequestDataNames.password: password,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.post(request: request);

    return AuthenticationModel.fromJson(response);
  }

  @override
  Future<AuthenticationModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final request = ApiRequestModel(
      endpoint: EndPoints.registerEndPoint,
      data: {
        RequestDataNames.email: email,
        RequestDataNames.password: password,
        RequestDataNames.name: name,
        RequestDataNames.phone: phone,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.post(request: request);

    return AuthenticationModel.fromJson(response);
  }
}
