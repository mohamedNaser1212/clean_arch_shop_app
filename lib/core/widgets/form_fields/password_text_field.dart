import 'package:flutter/material.dart';
import 'package:shop_app/core/functions/fields_validator.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_text_form_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;


  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Password',
      validator: FieldsValidator.isNotEmpty,
      controller: widget.controller,
      obscure: obscure,
      keyboardType: TextInputType.visiblePassword,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.key_rounded),
      suffix: IconButton(
        onPressed: (){
          obscure = !obscure;
          setState(() {});
        },
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
