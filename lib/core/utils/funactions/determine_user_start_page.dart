import 'package:flutter/cupertino.dart';

import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/layout/presentation/screens/layout_screen.dart';
import '../../networks/api_manager/api_helper.dart';
import 'check_user_status.dart';

Future<Widget> determineStartPage(
    BuildContext context, ApiHelper apiService) async {
  final bool isLoggedIn = await checkUserStatus(apiService);
  if (isLoggedIn) {
    return const LayoutScreen();
  } else {
    return LoginScreen();
  }
}
