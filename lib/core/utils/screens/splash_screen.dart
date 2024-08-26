import 'package:flutter/material.dart';
import 'package:shop_app/core/networks/api_manager/api_helper.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../../user_info/cubit/user_info_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserInfoCubit userInfoCubit = getIt<UserInfoCubit>();

  @override
  void initState() {
    super.initState();
    userInfoCubit.checkUserStatus(
        apiService: getIt.get<ApiHelper>(), context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/wallpaperflare.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
