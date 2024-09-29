import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screen/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form_body.dart';


class SettingsForm extends StatelessWidget {
  final  SettingsScreenState userState;

  const SettingsForm({
    Key? key,
    required this.userState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Form(
          key: userState.formKey,
          child: SettingsFormBody(
            userState: userState,
          
          ),
        ),
      ],
    ),
  );
  }


}
