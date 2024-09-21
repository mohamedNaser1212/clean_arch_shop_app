import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/sign_out_elevated_botton.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/update_elevated_borron.dart';

import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../authentication_feature/presentation/widgets/email_text_field.dart';

class SettingsFormBody extends StatelessWidget {
  const SettingsFormBody(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.formKey,
      required this.state});
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final UserInfoState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameField(controller: nameController),
        const SizedBox(height: 20.0),
        EmailField(controller: emailController),
        const SizedBox(height: 20.0),
        PhoneField(controller: phoneController),
        const SizedBox(height: 20.0),
        const SignOutElevatedBotton(),
        const SizedBox(height: 20.0),
        UpdateElevatedBotton(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
        ),
      ],
    );
  }
}
