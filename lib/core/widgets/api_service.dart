import 'package:dio/dio.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl;
  final String langHeader = 'en';

  ApiService(this._dio, this.baseUrl);

  Options _createOptions({Map<String, dynamic>? headers, String? token}) {
    final options = Options(headers: headers ?? {});
    options.headers!['lang'] = langHeader;
    if (token != null) {
      options.headers!['Authorization'] = 'Bearer $token';
    }
    return options;
  }

  Future<Map<String, dynamic>> get({
    required ApiRequestModel request,
    String? token,
  }) async {
    var options = _createOptions(headers: request.headers, token: token);
    var response =
        await _dio.get('$baseUrl${request.endpoint}', options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required ApiRequestModel request,
    String? token,
  }) async {
    var options = _createOptions(headers: request.headers, token: token);
    var response = await _dio.post('$baseUrl${request.endpoint}',
        data: request.data, options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required ApiRequestModel request,
    String? token,
  }) async {
    var options = _createOptions(headers: request.headers, token: token);
    var response = await _dio.put('$baseUrl${request.endpoint}',
        data: request.data, options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required ApiRequestModel request,
    String? token,
  }) async {
    var options = _createOptions(headers: request.headers, token: token);
    var response =
        await _dio.delete('$baseUrl${request.endpoint}', options: options);
    return response.data;
  }

  Future<Response> responsePost({
    required ApiRequestModel request,
    String? token,
  }) async {
    var options = _createOptions(headers: request.headers, token: token);
    return await _dio.post('$baseUrl${request.endpoint}',
        data: request.data, options: options);
  }
}
