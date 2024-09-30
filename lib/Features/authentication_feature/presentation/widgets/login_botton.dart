import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.state,
  }) : super(key: key);
  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return   CustomElevatedButton.loginButton(
      state: state,
      context: context,
    );
  }
}


