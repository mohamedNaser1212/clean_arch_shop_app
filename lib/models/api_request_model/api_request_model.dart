class HeaderModel {
  final String contentType;
  final String authorization;
  final String lang;

  HeaderModel({
    required this.contentType,
    required this.authorization,
    required this.lang,
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
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? data;

  ApiRequestModel({
    required this.endpoint,
    this.headers,
    this.query,
    this.data,
  });

  @override
  String toString() {
    print("=======================================");
    return 'ApiRequestModel(endpoint: $endpoint, headers: $headers, query: $query, data: $data)';
  }
}
