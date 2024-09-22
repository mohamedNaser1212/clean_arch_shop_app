import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ReusableTextFormField(
      label: 'Phone',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Phone must not be empty';
        }
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.phone,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.phone),
    );
  }
}
