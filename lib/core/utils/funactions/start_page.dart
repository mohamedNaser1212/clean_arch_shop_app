import 'package:flutter/material.dart';

import '../../../Features/onBoarding/onboarding_screen.dart';
import '../../../screens/layout_screen.dart';
import '../../../screens/login_screen.dart';
import '../../widgets/cache_helper.dart';
import '../../widgets/constants.dart';

Widget? startPage() {
  bool showBoardingScreen =
      CacheHelper.getData(key: 'showBoardingScreen') ?? true;
  token = CacheHelper.getData(key: 'token') ?? '';
  print(token);
  if (showBoardingScreen) {
    return OnBoardingScreen();
  } else if (token.isEmpty) {
    return LoginScreen();
  } else {
    return LayoutScreen();
  }
}
