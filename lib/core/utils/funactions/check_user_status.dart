import '../../networks/api_manager/api_helper.dart';
import '../../networks/api_manager/api_request_model.dart';
import '../../networks/api_manager/end_points.dart';

Future<bool> checkUserStatus(ApiHelper apiService) async {
  try {
    final response = await apiService.responseGet(
      request: ApiRequestModel(
        endpoint: EndPoints.profileEndPoint,
        headerModel: HeaderModel(),
      ),
    );
    return response.data['status'] == true;
  } catch (error) {
    return false;
  }
}
