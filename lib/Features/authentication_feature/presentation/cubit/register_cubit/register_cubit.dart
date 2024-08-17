import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../core/widgets/constants.dart';
import '../../../../../core/widgets/end_points.dart';
import '../../../../../core/widgets/reusable_widgets.dart';
import '../../../../authentication_feature/data/authentication_models/login_model.dart';
import '../../../../authentication_feature/domain/register_use_case/register_use_case.dart';
import '../../../../home/presentation/screens/layout_screen.dart';
import '../../../../settings_feature/presentation/cubit/get_user_info_cubit/get_user_data_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool obsecurePassword = true;
  IconData suffixPasswordIcon = Icons.visibility_rounded;

  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());

    final result = await registerUseCase.call(email, password, name, phone);

    result.fold(
      (failure) {
        emit(RegisterErrorState(failure.message));
        Fluttertoast.showToast(
          msg: failure.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      (loginModel) async {
        emit(RegisterSuccessState(loginModel: loginModel));

        // Ensure the context is still mounted before using it
        if (!context.mounted) return;

        // Register the new user in UserDataCubit and cache the token
        await UserDataCubit.get(context).registerNewUser(loginModel);
        await CacheHelper.saveData(key: 'token', value: loginModel.data!.token);

        token = loginModel.data!.token!;

        if (!context.mounted) return;

        // Navigate to the layout screen
        navigateAndFinish(context: context, screen: const LayoutScreen());

        final shopCubit = ShopCubit.get(context);
        shopCubit.currentIndex = 0;
        shopCubit.getHomeData();

        favorites.clear();
        carts.clear();

        Fluttertoast.showToast(
          msg: 'Register Success',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }
}
