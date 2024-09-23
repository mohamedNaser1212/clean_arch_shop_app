import 'package:flutter/material.dart';
import 'package:shop_app/core/managers/field_validaltor/fields_validator.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

import '../cubit/search_cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ReusableTextFormField(
        label: 'Search',
        controller: _controller,
        keyboardType: TextInputType.text,
        validator: FieldsValidator.isNotEmpty,
        suffix: IconButton(
          onPressed: () {
            _controller.clear();
          },
          icon: const Icon(Icons.close),
        ),
        onSubmit: (value) {
          if (_formKey.currentState!.validate()) {
            SearchCubit.get(context).search(text: _controller.text);
          }
          return null;
        },
        prefix: const Icon(Icons.search),
      ),
    );
  }
}
