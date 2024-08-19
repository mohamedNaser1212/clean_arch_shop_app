import 'package:flutter/material.dart';

import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/home/presentation/screens/layout_screen.dart';
import '../api_services/api_service_interface.dart';
import '../screens/widgets/cache_helper.dart';
import '../screens/widgets/constants.dart';
import '../screens/widgets/end_points.dart';
import '../screens/widgets/old_dio_helper.dart';

late final ApiServiceInterface apiService;
Future<bool> checkLoginStatus() async {
  token = CacheHelper.getData(key: 'token') ?? '';
  // if (token.isEmpty) {
  //   return false;
  // }
  print(token);
  try {
    final response = await DioHelper.getData(
      url: profileEndPoint,
      token: token,
    );
    return response.data['status'] == true;
  } catch (error) {
    return false;
  }
}

Future<Widget> determineStartPage(BuildContext context) async {
  final bool isLoggedIn = await checkLoginStatus();

  if (isLoggedIn) {
    return const LayoutScreen();
  } else {
    return LoginScreen();
  }
}
