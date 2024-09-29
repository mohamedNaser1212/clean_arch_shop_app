import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screen/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';

class UserInfoDisplay extends StatelessWidget {
  final SettingsScreenState userState;

  const UserInfoDisplay({
    Key? key,
    required this.userState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsForm(
      userState: userState,
    );
  }
}
