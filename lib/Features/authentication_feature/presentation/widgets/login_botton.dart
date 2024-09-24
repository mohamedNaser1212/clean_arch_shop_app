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
    return _LoginButton(state: state);
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.state,
  });

  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedBotton.loginButton(
          state: state,
          context: context,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
