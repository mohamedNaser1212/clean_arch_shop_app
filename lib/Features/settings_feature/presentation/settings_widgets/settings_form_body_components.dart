import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/Features/settings_feature/presentation/screen/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/sign_out_elevated_botton.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/update_elevated_borron.dart';

class SettingsFormBodyComponents extends StatelessWidget {
  const SettingsFormBodyComponents({super.key, required this.userState});
  final SettingsScreenState userState;

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              NameField(controller: userState.nameController),
              const SizedBox(height: 20.0),
              EmailField(controller: userState.emailController),
              const SizedBox(height: 20.0),
              PhoneField(controller: userState.phoneController),
              const SizedBox(height: 20.0),
              const SignOutElevatedBotton(),
              const SizedBox(height: 20.0),
              UpdateElevatedBotton(
                formKey: userState.formKey,
                userState: userState,
              ),
            ],
          );
  }
}