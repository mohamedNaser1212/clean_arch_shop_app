import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

UserInfoLocalDataSource userInfoLocalDataSource =
    getIt.get<UserInfoLocalDataSource>();

class HeaderModel {
  final String contentType;
  final Future<String?> authorization;
  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    String? authorization = '',
    this.lang = 'en',
  }) : authorization = userInfoLocalDataSource
            .loadUserData()
            .then((value) => value?.token ?? authorization);

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
