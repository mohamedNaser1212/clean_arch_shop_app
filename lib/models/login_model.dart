import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';

class LoginModel extends UserEntity {
  bool? status;
  String? message;
  UserData? data;

  LoginModel({
    required String name,
    required String email,
    required String phone,
    required String token,
    this.status,
    this.message,
    this.data,
  }) : super(name: name, email: email, phone: phone, token: token);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      name: json['data']?['name'] ?? '',
      email: json['data']?['email'] ?? '',
      phone: json['data']?['phone'] ?? '',
      token: json['data']?['token'] ?? '',
    );
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }
}
