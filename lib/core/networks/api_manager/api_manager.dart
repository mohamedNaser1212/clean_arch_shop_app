import 'api_request_model.dart';

abstract class ApiHelper {
  const ApiHelper();
  Future<Map<String, dynamic>> get({
    required ApiRequestModel request,
  });

  Future<Map<String, dynamic>> post({
    required ApiRequestModel request,
  });

  Future<Map<String, dynamic>> put({
    required ApiRequestModel request,
  });

  Future<Map<String, dynamic>> delete({
    required ApiRequestModel request,
  });
}
