import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../cubit/user_info_cubit/sign_out_cubit.dart';

class SignOutElevatedBotton extends StatelessWidget {
  const SignOutElevatedBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! UserSignOutLoading,
          builder: (context) => CustomElevatedButton.signOutButton(
          context: context,
        ),
          fallback: (context) {
            return const LoadingIndicatorWidget();
          },
        );
      },
    );
  }

  // CustomElevatedButton _builder(BuildContext context) {
  //   return CustomElevatedButton.signOutButton(
  //         context: context,
  //       );
  // }
}
