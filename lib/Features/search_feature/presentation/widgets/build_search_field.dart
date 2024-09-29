import 'package:flutter/material.dart';
import 'package:shop_app/core/managers/field_validaltor/fields_validator.dart';
import 'package:shop_app/core/widgets/reusable_text_form_field.dart';
import '../cubit/search_cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:ReusableTextFormField(
      label: 'Search',
      controller: _controller,
      keyboardType: TextInputType.text,
      validator: FieldsValidator.isNotEmpty,
      suffix: IconButton(
        onPressed: () => _clearTextField(),
        icon: const Icon(Icons.close),
      ),
      onSubmit: (value) => _onSearchSubmit(context), 
      prefix: const Icon(Icons.search),
    )
    );
  }


  void _clearTextField() {
    _controller.clear();
  }

  String? _onSearchSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      SearchCubit.get(context).search(text: _controller.text);
    }
    return null; 
  }
}
