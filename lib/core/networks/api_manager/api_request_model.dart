import 'package:shop_app/core/utils/widgets/token_storage_helper.dart';

import '../../../Features/authentication_feature/data/authentication_models/authentication_model.dart';

AuthenticationModel? loginModel;

class HeaderModel {
  final String contentType;
  final String authorization;
  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    String? authorization,
    this.lang = 'en',
  }) : authorization = HiveHelper.getToken();

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
  final HeaderModel headerModel;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? data;

  ApiRequestModel({
    required this.endpoint,
    HeaderModel? headerModel,
    this.query,
    this.data,
  })  : headerModel = headerModel!,
        headers = headerModel.toMap();

  final Map<String, dynamic> headers;

  @override
  String toString() {
    print("=======================================");
    return 'ApiRequestModel(endpoint: $endpoint, headers: $headers, query: ${query ?? ''}, data: ${data ?? ''})';
  }
}
