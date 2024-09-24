import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../cubit/user_info_cubit/update_user_data_cubit.dart';

class UpdateElevatedBotton extends StatelessWidget {
  const UpdateElevatedBotton({
    super.key,
    required this.formKey,
    required this.userState,
  });

  final GlobalKey<FormState> formKey;
  final SettingsScreenState userState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
      builder: (context, updateState) {
        return _builder(updateState);
      },
    );
  }

  ConditionalBuilder _builder(UpdateUserDataState updateState) {
    return ConditionalBuilder(
        condition: updateState is! UpdateUserDataLoading,
        builder: (context) {
          return CustomElevatedBotton.updateButton(
            context: context,
            userState: userState,
            formKey: formKey,
          );
        },
        fallback: (context) => const LoadingIndicatorWidget(),
      );
  }
}
