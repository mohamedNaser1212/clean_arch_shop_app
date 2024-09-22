import 'package:flutter/material.dart';
import 'package:shop_app/core/classes/field_validator.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Name',
      validator: FieldValidator.isNotEmpty,
      controller: controller,
      keyboardType: TextInputType.text,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.person),
    );
  }
}
