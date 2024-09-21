import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form_body.dart';

import '../../../../core/user_info/cubit/user_info_cubit.dart';

class SettingsForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final UserInfoState state;

  const SettingsForm({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: SettingsFormBody(
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
          formKey: formKey,
          state: state,
        ),
      ),
    );
  }
}
