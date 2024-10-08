import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

class UpdateUserRequestModel {
  final String name;
  final String email;
  final String phone;

  UpdateUserRequestModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
    RequestDataNames.name: name,
      RequestDataNames.email: email,
      RequestDataNames.phone : phone,
    };
  }
}