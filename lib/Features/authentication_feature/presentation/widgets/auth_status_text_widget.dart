import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class AuthStatusTextWidget extends StatelessWidget {
  const AuthStatusTextWidget._({
    required this.onRegisterPressed,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onRegisterPressed;
  final String title;
  final String subtitle;

  factory AuthStatusTextWidget.login({
    required BuildContext context,
  }) {
    return AuthStatusTextWidget._(
      onRegisterPressed: () {
        NavigationManager.navigateTo(
            context: context, screen: const RegisterScreen());
      },
      title: 'Don\'t have an account?',
      subtitle: 'Register',
    );
  }

  factory AuthStatusTextWidget.register({
    required BuildContext context,
  }) {
    return AuthStatusTextWidget._(
      onRegisterPressed: () {
        Navigator.of(context).pop();
      },
      title: 'Already have an account?',
      subtitle: 'Login',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTitle(
          title: title,
          style: TitleStyle.style18,
        ),
        TextButton(
          onPressed: onRegisterPressed,
          child: CustomTitle(
            title: subtitle,
            color: ColorController.blueAccentColor,
            style: TitleStyle.styleBold18,
          ),
        ),
      ],
    );
  }
}
