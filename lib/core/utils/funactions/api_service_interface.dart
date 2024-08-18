import 'package:dio/dio.dart';

import '../../models/api_request_model/api_request_model.dart';

abstract class ApiServiceInterface {
  Future<Map<String, dynamic>> get({
    required ApiRequestModel request,
    String? token,
  });

  Future<Map<String, dynamic>> post({
    required ApiRequestModel request,
    String? token,
  });

  Future<Map<String, dynamic>> put({
    required ApiRequestModel request,
    String? token,
  });

  Future<Map<String, dynamic>> delete({
    required ApiRequestModel request,
    String? token,
  });

  Future<Response> responsePost({
    required ApiRequestModel request,
    String? token,
  });
}
