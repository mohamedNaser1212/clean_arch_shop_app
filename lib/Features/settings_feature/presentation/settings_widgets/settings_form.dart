import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form_body.dart';


class SettingsForm extends StatelessWidget {
  final  SettingsScreenState userState;



  const SettingsForm({
    Key? key,
    required this.userState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Padding _body() {
    return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
      key: userState.formKey,
      child: SettingsFormBody(
        userState: userState,
      
      ),
    ),
  );
  }
}
