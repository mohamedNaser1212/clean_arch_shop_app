import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/reusable_widgets.dart';
import '../../../search_feature/presentation/cubit/search_cubit/search_cubit.dart';

class BuildSearchField extends StatelessWidget {
  BuildSearchField({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: reusableTextFormField(
        label: 'Search',
        controller: _controller,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Search must not be empty';
          }
          return null;
        },
        onSubmit: (value) {
          if (_formKey.currentState?.validate() ?? false) {
            SearchCubit.get(context).search(text: value!);
          }
        },
        prefix: const Icon(Icons.search),
        onTap: () {},
      ),
    );
  }
}
