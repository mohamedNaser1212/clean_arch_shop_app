import '../../../settings_feature/domain/user_entity/user_entity.dart';

class AuthenticationModel extends UserEntity {
  final String message;

  const AuthenticationModel({
    required this.message,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      message: json['message'] ?? '',
      name: json['data']['name'],
      email: json['data']['email'],
      phone: json['data']['phone'],
      token: json['data']['token'],
    );
  }
}
