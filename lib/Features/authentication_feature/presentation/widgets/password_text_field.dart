import 'package:flutter/material.dart';
import 'package:shop_app/core/classes/fields_validator.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onSuffixPressed;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.onSuffixPressed,
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
        onPressed: onSuffixPressed,
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
