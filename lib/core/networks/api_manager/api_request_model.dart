import 'package:shop_app/core/networks/Hive_manager/hive_boxes_names.dart';

import '../../../Features/authentication_feature/data/authentication_models/authentication_model.dart';
import '../Hive_manager/hive_manager.dart';

AuthenticationModel? loginModel;

class HeaderModel {
  final String contentType;
  final Future<String> authorization;
  final String lang;

  HeaderModel({
    this.contentType = 'application/json',
    String? authorization,
    this.lang = 'en',
  }) : authorization = _getToken();

  static Future<String> _getToken() async {
    final hiveManager = HiveManager();
    final token = await hiveManager.loadSingleItem<String>(
        'token', HiveBoxesNames.kSaveTokenBox);
    print('Token: $token');
    return token ?? ''; // Handle null case
  }

  Future<Map<String, dynamic>> toMap() async {
    final auth = await authorization;
    return {
      'Content-Type': contentType,
      'Authorization': auth,
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
