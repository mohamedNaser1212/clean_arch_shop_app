import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_builder.dart';
import 'package:shop_app/core/functions/toast_function.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/utils/styles_manager/text_styles_manager.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/reusable_widgets/reusable_elevated_botton.dart';
import '../../../../core/widgets/reusable_widgets/reusable_text_form_field.dart';
import '../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: _listener,
      builder: (context, state) => RegisterScreenBuilder(
        state: state,
      ),
    );
  }
}

Future<void> _listener(BuildContext context, RegisterState state) async {
  if (state is RegisterSuccessState) {
    showToast(
      isError: false,
      message: 'Register Success',
    );

    if (context.mounted) {
      ProductsCubit.get(context).homeModel;

      UserInfoCubit.get(context).userEntity = state.userModel;

      NavigationManager.navigateAndFinish(
          context: context, screen: const LayoutScreen());
    }
  } else if (state is RegisterErrorState) {
    showToast(
      isError: false,
      message: state.message,
    );
  }
}
