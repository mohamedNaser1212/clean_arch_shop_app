import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';

class AuthenticationModel extends UserEntity {
  final String? message;

  const AuthenticationModel({
    required this.message,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return AuthenticationModel(
      message: json['message'] as String?,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      token: data['token'] ?? '',
    );
  }
}
