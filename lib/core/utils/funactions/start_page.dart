import 'package:flutter/material.dart';

import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/home/presentation/screens/layout_screen.dart';
import '../../networks/api_manager/api_request_model.dart';
import '../../networks/api_manager/api_service_interface.dart';
import '../../networks/api_manager/end_points.dart';

Future<bool> checkLoginStatus(ApiHelper apiService) async {
  try {
    final response = await apiService.responseGet(
      request: ApiRequestModel(
        endpoint: EndPoints.profileEndPoint,
        headerModel: HeaderModel(),
      ),
    );
    return response.data['status'] == true;
  } catch (error) {
    return false;
  }
}

Future<Widget> determineStartPage(
    BuildContext context, ApiHelper apiService) async {
  final bool isLoggedIn = await checkLoginStatus(apiService);
  if (isLoggedIn) {
    return const LayoutScreen();
  } else {
    return LoginScreen();
  }
}
