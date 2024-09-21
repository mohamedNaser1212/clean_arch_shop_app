import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

class HeaderModel {
  final String contentType;
  late final Future<String?> authorization;

  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    String? authToken = '',
    this.lang = 'en',
  }) {
    UserInfoLocalDataSource userInfoLocalDataSource =
        getIt.get<UserInfoLocalDataSource>();

    authorization = userInfoLocalDataSource
        .loadUserData()
        .then((value) => value?.token ?? authToken);
  }

  Future<Map<String, dynamic>> toMap() async {
    final auth = await authorization;
    print('auth: $auth');
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
    headers = headerModel.toMap();
  }

  @override
  String toString() {
    print("=======================================");
    return 'ApiRequestModel(endpoint: $endpoint, headers: $headers, query: ${query ?? ''}, data: ${data ?? ''})';
  }
}
