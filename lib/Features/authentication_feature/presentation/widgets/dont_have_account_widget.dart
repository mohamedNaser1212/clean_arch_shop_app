import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class CheckAuthStatusTextWidget extends StatelessWidget {
  const CheckAuthStatusTextWidget({
    super.key,
    required this.onRegisterPressed,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onRegisterPressed;
  final String title;
  final String subtitle;

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
