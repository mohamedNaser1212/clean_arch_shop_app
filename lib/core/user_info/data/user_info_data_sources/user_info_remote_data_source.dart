import '../../../../Features/authentication_feature/data/model/user_model.dart';
import '../../../networks/api_manager/api_manager.dart';
import '../../../networks/api_manager/api_request_model.dart';
import '../../../networks/api_manager/end_points.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource._();

  Future<UserModel> getUser();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final ApiHelper apiHelper;

  const UserInfoRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<UserModel> getUser() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.profileEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.get(request: request);

    final loginModel = UserModel.fromJson(response);
    return loginModel;
  }
}
