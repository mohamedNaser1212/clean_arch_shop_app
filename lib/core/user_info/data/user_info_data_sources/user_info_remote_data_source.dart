import '../../../networks/api_manager/api_helper.dart';
import '../../../networks/api_manager/api_request_model.dart';
import '../../../networks/api_manager/end_points.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource();
  Future<bool> checkUserStatus({
    required ApiHelper apiService,
  });
  Future<String> getUserToken();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final ApiHelper apiHelper;

  const UserInfoRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<String> getUserToken() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.profileEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.get(request: request);
    final token = response['data']['token'] as String;
    return token;
  }

  @override
  Future<bool> checkUserStatus({required ApiHelper apiService}) async {
    final response = await apiService.responseGet(
      request: ApiRequestModel(
        endpoint: EndPoints.profileEndPoint,
        headerModel: HeaderModel(),
      ),
    );
    return response.data['status'] == true ? true : false;
  }
}
