import 'package:dio/dio.dart';

import 'api_request_model.dart';
import 'api_service_interface.dart';

class ApiService implements ApiServiceInterface {
  final Dio _dio;
  final String baseUrl;

  ApiService(this._dio, this.baseUrl);

  Options _createOptions(Map<String, dynamic>? headers) {
    return Options(headers: headers ?? {});
  }

  @override
  Future<Map<String, dynamic>> get({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    var response =
        await _dio.get('$baseUrl${request.endpoint}', options: options);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> post({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    var response = await _dio.post('$baseUrl${request.endpoint}',
        data: request.data, options: options);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> put({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    var response = await _dio.put('$baseUrl${request.endpoint}',
        data: request.data, options: options);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> delete({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    var response =
        await _dio.delete('$baseUrl${request.endpoint}', options: options);
    return response.data;
  }

  @override
  Future<Response> responsePost({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    return await _dio.post('$baseUrl${request.endpoint}',
        data: request.data, options: options);
  }

  @override
  Future<Response> responsePut({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    return await _dio.put('$baseUrl${request.endpoint}',
        data: request.data, options: options);
  }

  @override
  Future<Response> responseDelete({
    required ApiRequestModel request,
  }) async {
    var options = _createOptions(request.headers);
    return await _dio.delete('$baseUrl${request.endpoint}', options: options);
  }

  @override
  Future<Response> responseGet({
    required ApiRequestModel request,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    var options = _createOptions(request.headers);

    return await _dio.get(
      '$baseUrl${request.endpoint}',
      queryParameters: query,
      options: options,
    );
  }
}
