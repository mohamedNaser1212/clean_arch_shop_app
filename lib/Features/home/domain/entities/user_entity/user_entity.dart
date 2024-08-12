import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 5)
class UserEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String token; // Add this field if it's part of the API response

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.token, // Include in constructor
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '', // Ensure all fields are mapped
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token, // Include in JSON conversion
    };
  }
}
