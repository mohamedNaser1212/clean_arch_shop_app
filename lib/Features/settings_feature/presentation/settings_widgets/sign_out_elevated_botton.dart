import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/reusable_widgets/reusable_elevated_botton.dart';
import '../cubit/user_info_cubit/sign_out_cubit.dart';

class SignOutElevatedBotton extends StatelessWidget {
  const SignOutElevatedBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! UserSignOutLoading,
          builder: (context) => ReusableElevatedButton(
            label: 'Sign Out',
            onPressed: () {
              SignOutCubit.get(context).signOut();
            },
            backColor: ColorController.warningColor,
            textColor: ColorController.buttonTextColor,
          ),
          fallback: (context) => const Center(child: LoadingIndicatorWidget()),
        );
      },
    );
  }
}
