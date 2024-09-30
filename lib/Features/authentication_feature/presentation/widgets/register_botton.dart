import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_body.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final RegisterScreenBodyState state;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.registerButton(
      context: context,
      state: state,
    );
  }
}
