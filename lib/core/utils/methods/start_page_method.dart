import 'package:flutter/material.dart';

import '../../../Features/onBoarding/onboarding_screen.dart';
import '../../../screens/layout_screen.dart';
import '../../../screens/login_screen.dart';
import '../../widgets/cache_helper.dart';
import '../../widgets/constants.dart';

Widget? start_page(Widget? startingScreen) {
  bool showBoardingScreen =
      CacheHelper.getData(key: 'showBoardingScreen') ?? true;
  token = CacheHelper.getData(key: 'token') ?? '';
  print(token);
  if (showBoardingScreen) {
    startingScreen = OnBoardingScreen();
  } else {
    if (token == '') {
      startingScreen = LoginScreen();
    } else {
      startingScreen = const LayoutScreen();
      print('token: $token');
    }
  }
  return startingScreen;
}
