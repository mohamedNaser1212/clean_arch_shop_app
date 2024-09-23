import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';
import '../cubit/user_info_cubit/sign_out_cubit.dart';

class SignOutElevatedBotton extends StatelessWidget {
  const SignOutElevatedBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return CustomElevatedBotton.signOutButton(
          context: context,
        );
      },
    );
  }
}
