import '../../utils/screens/widgets/constants.dart';

class HeaderModel {
  final String contentType;
  final String authorization;
  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    required this.authorization,
    this.lang = 'en',
  });

  Map<String, dynamic> toMap() {
    return {
      'Content-Type': contentType,
      'Authorization': authorization,
      'lang': lang,
    };
  }
}

class ApiRequestModel {
  final String endpoint;
  final Map<String, dynamic> headers;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? data;

  ApiRequestModel({
    required this.endpoint,
    Map<String, dynamic>? headers,
    this.query,
    this.data,
  }) : headers = {
          'Authorization': token,
          ...?headers,
          'Content-Type': 'application/json',
          'lang': 'en',
        };

  @override
  String toString() {
    print("=======================================");
    return 'ApiRequestModel(endpoint: $endpoint, headers: ${headers ?? ''}, query: ${query ?? ''}, data: ${data ?? ''})';
  }
}
