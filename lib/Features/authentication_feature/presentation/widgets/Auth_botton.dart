import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_botton.dart';

class AuthButtons extends StatelessWidget {
  final bool isLoginPage;
  final VoidCallback action;
  final VoidCallback executeSecondaryAction;

  const AuthButtons({
    Key? key,
    required this.isLoginPage,
    required this.action,
    required this.executeSecondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoginPage
        ? LoginButton(
            onLoginPressed: action,
            onRegisterPressed: executeSecondaryAction,
          )
        : RegisterButton(
            onRegisterPressed: action,
            onLoginPressed: executeSecondaryAction,
          );
  }
}
