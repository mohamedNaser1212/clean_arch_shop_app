import 'package:dio/dio.dart';

import 'api_request_model.dart';

abstract class ApiHelper {
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

  Future<Response> responsePost({
    required ApiRequestModel request,
  });

  Future<Response> responsePut({
    required ApiRequestModel request,
  });

  Future<Response> responseDelete({
    required ApiRequestModel request,
  });

  Future<Response> responseGet({
    required ApiRequestModel request,
  });
}
