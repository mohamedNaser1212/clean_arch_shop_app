import 'package:dio/dio.dart';

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
    required String endPoint,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    var options = _createOptions(headers: headers, token: token);
    var response = await _dio.get('$baseUrl$endPoint', options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    var options = _createOptions(headers: headers, token: token);
    var response =
        await _dio.post('$baseUrl$endPoint', data: data, options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    var options = _createOptions(headers: headers, token: token);
    var response =
        await _dio.put('$baseUrl$endPoint', data: data, options: options);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    var options = _createOptions(headers: headers, token: token);
    var response = await _dio.delete('$baseUrl$endPoint', options: options);
    return response.data;
  }

  Future<Response> responsePost({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    var options = _createOptions(
      headers: headers,
    );
    var response =
        await _dio.post('$baseUrl$endPoint', data: data, options: options);
    return response.data;
  }
}
