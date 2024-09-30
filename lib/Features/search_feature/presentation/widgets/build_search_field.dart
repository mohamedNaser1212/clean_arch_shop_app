import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_form_field.dart';


class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SearchFormField(
      
    );
  }
}
