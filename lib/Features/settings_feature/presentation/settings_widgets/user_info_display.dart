import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';

class UserInfoDisplay extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final UserInfoState userState;

  const UserInfoDisplay({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
    required this.userState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (userState is GetUserInfoLoadingState)
          const LinearProgressIndicator(),
        SettingsForm(
          emailController: emailController,
          nameController: nameController,
          phoneController: phoneController,
          formKey: formKey,
        ),
      ],
    );
  }


}
