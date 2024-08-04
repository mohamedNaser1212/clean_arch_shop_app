import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../../core/widgets/dio_helper.dart';
import '../../../../core/widgets/end_points.dart';

abstract class GetUserDataDataSource {
  Future<LoginModel> getUserData();
  Future<LoginModel> UpdateUserData({
    required String name,
    required String email,
    required String phone,
  });
}

class GetUserDataDataSourceImpl implements GetUserDataDataSource {
  final ApiService apiService;
  LoginModel? _cachedUserData;

  GetUserDataDataSourceImpl({required this.apiService});

  @override
  Future<LoginModel> getUserData() async {
    if (_cachedUserData != null) {
      return _cachedUserData!;
    }

    try {
      final response = await apiService
          .get(endPoint: profileEndPoint, headers: {'Authorization': token});

      _cachedUserData = LoginModel.fromJson(response);
      return _cachedUserData!;
    } catch (e) {
      print('Error fetching user data: $e');
      throw e;
    }
  }

  @override
  Future<LoginModel> UpdateUserData(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      final response = await apiService.put(
        endPoint: updateProfileEndPoint,
        headers: {'Authorization': token},
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );

      _cachedUserData = LoginModel.fromJson(response);
      return _cachedUserData!;
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }
}
