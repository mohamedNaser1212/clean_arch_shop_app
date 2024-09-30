import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';
import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json[RequestDataNames.data] as Map<String, dynamic>? ?? {};
    return UserModel(
      name: data[RequestDataNames.name] ?? '',
      email: data[RequestDataNames.email] ?? '',
      phone: data[RequestDataNames.phone] ?? '',
      token: data[RequestDataNames.token] ?? '',
    );
  }
}
