import 'package:flutter/material.dart';
import 'package:shop_app/core/classes/field_validator.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Email',
      validator: FieldValidator.isNotEmpty,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.email_rounded),
    );
  }
}
