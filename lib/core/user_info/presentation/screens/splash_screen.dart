import 'package:flutter/material.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../cubit/user_info_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserInfoCubit userInfoCubit = getIt<UserInfoCubit>();

  @override
  void initState() {
    super.initState();
    userInfoCubit.checkUserStatus(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/groot.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
