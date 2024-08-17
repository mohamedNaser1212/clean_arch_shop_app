import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/home/presentation/screens/layout_screen.dart';
import '../../widgets/cache_helper.dart';
import '../../widgets/old_dio_helper.dart';

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
