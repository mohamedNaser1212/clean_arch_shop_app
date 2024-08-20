import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/home/presentation/screens/layout_screen.dart';
import '../../models/api_request_model/api_request_model.dart';
import '../api_services/api_service_interface.dart';
import '../end_points/end_points.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
}

Future<String> getTokenss() async {
  final userBox = Hive.box('userBox');
  return userBox.get('token', defaultValue: '') as String;
}

Future<bool> checkLoginStatus(ApiServiceInterface apiService) async {
  final token = await getTokenss();

  try {
    final response = await apiService.responseGet(
      request: ApiRequestModel(
        endpoint: EndPoints.profileEndPoint,
        headerModel: HeaderModel(authorization: token),
      ),
    );

    return response.data['status'] == true;
  } catch (error) {
    return false;
  }
}

Future<Widget> determineStartPage(
    BuildContext context, ApiServiceInterface apiService) async {
  final bool isLoggedIn = await checkLoginStatus(apiService);

  if (isLoggedIn) {
    return const LayoutScreen();
  } else {
    return LoginScreen();
  }
}
