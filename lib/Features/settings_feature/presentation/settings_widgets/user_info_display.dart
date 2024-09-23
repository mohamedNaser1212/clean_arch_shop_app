import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';

class UserInfoDisplay extends StatelessWidget {
  final SettingsScreenState userState;

   UserInfoDisplay({
    Key? key,
    required this.userState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (userState is GetUserInfoLoadingState)
          const LinearProgressIndicator(),
        SettingsForm(
          userState: userState,
        ),
      ],
    );
  }
}
