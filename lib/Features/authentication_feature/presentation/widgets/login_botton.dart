import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const LoginButton({
    Key? key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableElevatedButton(
          label: 'Login',
          onPressed: onLoginPressed,
          backColor: ColorController.blueAccentColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTitle(
              title: 'Don\'t have an account?',
              style: TitleStyle.style18,
            ),
            TextButton(
              onPressed: onRegisterPressed,
              child: const CustomTitle(
                title: 'Register',
                color: ColorController.blueAccentColor,
                style: TitleStyle.styleBold18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
