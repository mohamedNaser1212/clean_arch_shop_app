import '../../../../Features/authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../networks/api_manager/api_helper.dart';
import '../../../networks/api_manager/api_request_model.dart';
import '../../../networks/api_manager/end_points.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource();

  Future<AuthenticationModel> getUser();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final ApiHelper apiHelper;

  const UserInfoRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<AuthenticationModel> getUser() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.profileEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.get(request: request);

    final loginModel = AuthenticationModel.fromJson(response);
    return loginModel;
  }
}
