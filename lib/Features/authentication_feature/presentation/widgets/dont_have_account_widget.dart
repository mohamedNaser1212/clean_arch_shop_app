import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class CheckAuthStatusTextWidget extends StatelessWidget {
  const CheckAuthStatusTextWidget._({
    required this.onRegisterPressed,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onRegisterPressed;
  final String title;
  final String subtitle;

  factory CheckAuthStatusTextWidget.login({
    required VoidCallback onRegisterPressed,
  }) {
    return CheckAuthStatusTextWidget._(
      onRegisterPressed: onRegisterPressed,
      title: 'Don\'t have an account?',
      subtitle: 'Register',
    );
  }

  factory CheckAuthStatusTextWidget.register({
    required VoidCallback onRegisterPressed,
  }) {
    return CheckAuthStatusTextWidget._(
      onRegisterPressed: onRegisterPressed,
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
