import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      token: data['token'] ?? '',
    );
  }
}
