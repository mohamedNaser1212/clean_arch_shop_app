import 'package:shop_app/Features/authentication_feature/data/authentication_models/user_data_model.dart';

import '../../../settings_feature/domain/user_entity/user_entity.dart';

class AuthenticationModel extends UserEntity {
  final bool? status;
  final String? message;
  final UserData? data;

  AuthenticationModel({
    this.status,
    this.message,
    this.data,
  }) : super(
            name: data?.name ?? '',
            email: data?.email ?? '',
            phone: data?.phone ?? '',
            token: data?.token ?? '');

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}
