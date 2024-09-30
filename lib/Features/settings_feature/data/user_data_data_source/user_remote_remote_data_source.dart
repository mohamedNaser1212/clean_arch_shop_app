import 'package:shop_app/Features/settings_feature/data/update_user_request_model.dart';

import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';

import '../../../../core/networks/api_manager/end_points.dart';
import '../../../authentication_feature/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  const UserRemoteDataSource._();

  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,

  });
  Future<bool> signOut();
}

class UserDataSourceImpl implements UserRemoteDataSource {
  final ApiHelper apiHelper;

  const UserDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<UserModel> updateUserData({
     required UpdateUserRequestModel updateUserRequestModel,

  }) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.updateProfileEndPoint,
      data: updateUserRequestModel.toMap(),
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.put(request: request);
    final loginModel = UserModel.fromJson(response);
    return loginModel;
  }

  @override
  Future<bool> signOut() async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.logOutEndPoint, headerModel: HeaderModel());
    final response = await apiHelper.post(request: request);
    return response['status'];
  }
}
