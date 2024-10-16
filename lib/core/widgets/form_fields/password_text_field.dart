import 'package:flutter/material.dart';
import 'package:shop_app/core/functions/fields_validator.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure=true;


  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Password',
      validator: FieldsValidator.isNotEmpty,
      controller: controller,
      obscure: obscure,
      keyboardType: TextInputType.visiblePassword,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.key_rounded),
      suffix: IconButton(
        onPressed: (){},
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
