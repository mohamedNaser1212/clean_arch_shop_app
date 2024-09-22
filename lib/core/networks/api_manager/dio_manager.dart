import 'package:dio/dio.dart';

import 'api_manager.dart';
import 'api_request_model.dart';

class DioManager implements ApiHelper {
  final Dio dio;
  final String baseUrl;

  const DioManager({
    required this.dio,
    required this.baseUrl,
  });

  Options _createOptions(Map<String, dynamic>? headers) {
    return Options(headers: headers ?? {});
  }

  Future<Map<String, dynamic>> _getHeaders(ApiRequestModel request) async {
    return await request.headers;
  }

  Future<dynamic> _handleResponse(Response response) async {
    if ([200, 201, 202].contains(response.statusCode)) {
      if (response.data['status'] == false) {
        print('response.data: ${response.data['message']}');
        throw Exception(
          '${response.data['message']}',
        );
      }
      return response.data ?? {};
    } else {
      throw Exception(
        '${response.data['message']}',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> get({required ApiRequestModel request}) async {
    final headers = await _getHeaders(request);
    var options = _createOptions(headers);
    var response =
        await dio.get('$baseUrl${request.endpoint}', options: options);
    return await _handleResponse(response);
  }

  @override
  Future<Map<String, dynamic>> post({required ApiRequestModel request}) async {
    final headers = await _getHeaders(request);
    var options = _createOptions(headers);
    var response = await dio.post(
      '$baseUrl${request.endpoint}',
      data: request.data,
      options: options,
    );
    return await _handleResponse(response);
  }

  @override
  Future<Map<String, dynamic>> put({required ApiRequestModel request}) async {
    final headers = await _getHeaders(request);
    var options = _createOptions(headers);
    var response = await dio.put(
      '$baseUrl${request.endpoint}',
      data: request.data,
      options: options,
    );
    return await _handleResponse(response);
  }

  @override
  Future<Map<String, dynamic>> delete(
      {required ApiRequestModel request}) async {
    final headers = await _getHeaders(request);
    var options = _createOptions(headers);
    var response =
        await dio.delete('$baseUrl${request.endpoint}', options: options);
    return await _handleResponse(response);
  }
}
