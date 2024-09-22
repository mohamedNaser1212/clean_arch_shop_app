import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Name',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name must not be empty';
        }
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.text,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.person),
    );
  }
}
