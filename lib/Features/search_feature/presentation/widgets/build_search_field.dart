import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_form_field.dart';


class SearchField extends StatelessWidget {
  SearchField({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SearchFormField(),
    );
  }
}
