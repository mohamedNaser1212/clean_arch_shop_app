import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form_body.dart';

// ignore: must_be_immutable
class SettingsForm extends StatefulWidget {
  const SettingsForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsForm> createState() => SettingsFormState();
}

class SettingsFormState extends State<SettingsForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: SettingsFormBody(
              formState: this,
            ),
          ),
        ],
      ),
    );
  }
}
