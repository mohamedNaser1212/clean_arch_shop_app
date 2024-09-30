import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/screen/settings_screen.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../cubit/user_info_cubit/update_user_data_cubit/update_user_data_cubit.dart';

class UpdateElevatedBotton extends StatelessWidget {
  const UpdateElevatedBotton({
    super.key,
    
    required this.userState,
  });


  final SettingsScreenState userState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
      builder: (context, updateState) {
        return ConditionalBuilder(
          condition: updateState is! UpdateUserDataLoading,
          builder: (context) => _builder(context),
          fallback: (context) => const LoadingIndicatorWidget(),
        );
      },
    );
  }

  CustomElevatedButton _builder(BuildContext context) {
    return CustomElevatedButton.updateButton(
          context: context,
          userState: userState,
       
        );
  }


}
