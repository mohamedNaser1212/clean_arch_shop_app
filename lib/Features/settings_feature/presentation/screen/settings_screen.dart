import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit/update_user_data_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_screen_body.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../domain/settings_use_case/update_user_data_use_case.dart';
import '../../domain/settings_use_case/user_sign_out_use_case.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    UserInfoCubit.get(context).getUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserDataCubit(
            updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => SignOutCubit(
            userSignOutUseCase: getIt.get<UserSignOutUseCase>(),
          ),
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, userState) {
    if (userState is GetUserInfoSuccessState) {
      nameController.text = userState.userEntity!.name;
      emailController.text = userState.userEntity!.email;
      phoneController.text = userState.userEntity!.phone;
    }
    print('name: ${nameController.text}');
    return BlockInteractionLoadingWidget(
      isLoading: userState is GetUserInfoLoadingState,
      child: SettingsScreenBody(
        userState: this,
      ),
    );
  }
}
