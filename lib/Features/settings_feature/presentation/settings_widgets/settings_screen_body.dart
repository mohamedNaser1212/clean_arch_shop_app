import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/update_user_data_use_case.dart';
import 'package:shop_app/Features/settings_feature/domain/settings_use_case/user_sign_out_use_case.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit/update_user_data_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  void initState() {
    super.initState();
    UserInfoCubit.get(context).getUserData();
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
        builder: (context, userState) {
          return BlockInteractionLoadingWidget(
            isLoading: userState is GetUserInfoLoadingState,
            child: const SettingsForm(),
          );
        },
      ),
    );
  }
}
