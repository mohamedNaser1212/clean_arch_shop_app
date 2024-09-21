import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onRegisterPressed;
  final VoidCallback onLoginPressed;

  const RegisterButton({
    Key? key,
    required this.onRegisterPressed,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableElevatedButton(
          label: 'Register',
          onPressed: onRegisterPressed,
          backColor: ColorController.blueAccentColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTitle(
              title: 'Already have an account?',
              color: ColorController.blackColor,
              style: TitleStyle.style18,
            ),
            TextButton(
              onPressed: onLoginPressed,
              child: const CustomTitle(
                title: 'Login',
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
