import 'package:shop_app/Features/settings_feature/data/user_data_data_source/user_local_data_source.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../../../Features/authentication_feature/data/authentication_models/authentication_model.dart';

AuthenticationModel? loginModel;
UserLocalDataSource userInfoLocalDataSource = getIt.get<UserLocalDataSource>();

class HeaderModel {
  final String contentType;
  final Future<String?> authorization;
  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    String? authorization,
    this.lang = 'en',
  }) : authorization = userInfoLocalDataSource
            .loadUserData()
            .then((value) => value?.token ?? authorization);

  Future<Map<String, dynamic>> toMap() async {
    final auth = await authorization;
    return {
      'Content-Type': contentType,
      'Authorization': auth ?? '',
      'lang': lang,
    };
  }
}

class ApiRequestModel {
  final String endpoint;
  final HeaderModel headerModel;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? data;

  late final Future<Map<String, dynamic>> headers;

  ApiRequestModel({
    required this.endpoint,
    required this.headerModel,
    this.query,
    this.data,
  }) {
    // Initialize the headers asynchronously
    headers = headerModel.toMap();
  }

  @override
  String toString() {
    print("=======================================");
    return 'ApiRequestModel(endpoint: $endpoint, headers: $headers, query: ${query ?? ''}, data: ${data ?? ''})';
  }
}
