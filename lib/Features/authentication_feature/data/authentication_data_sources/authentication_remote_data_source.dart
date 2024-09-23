import 'package:shop_app/features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/features/authentication_feature/data/model/user_model.dart';

import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';

import '../../../../core/networks/api_manager/end_points.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();
  Future<UserModel> login({
    required LoginRequestModel requestModel,
  });
  Future<UserModel> register({
    required RegisterRequestModel requestModel,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  final ApiHelper apiHelper;

  const AuthenticationDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<UserModel> login({
    required LoginRequestModel requestModel,
  }) async {
    final request = ApiRequestModel(
      endpoint: EndPoints.loginEndPoint,
      data: requestModel.toMap(),
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.post(request: request);

    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> register({
    required RegisterRequestModel requestModel,
  }) async {
    final request = ApiRequestModel(
      endpoint: EndPoints.registerEndPoint,
      data: requestModel.toMap(),
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.post(request: request);

    return UserModel.fromJson(response);
  }
}
