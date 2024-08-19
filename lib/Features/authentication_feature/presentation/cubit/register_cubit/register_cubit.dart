import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';

import '../../../../../core/utils/screens/widgets/cache_helper.dart';
import '../../../../../core/utils/screens/widgets/constants.dart';
import '../../../../../core/utils/screens/widgets/end_points.dart';
import '../../../../../core/utils/screens/widgets/reusable_widgets.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../home/presentation/screens/layout_screen.dart';
import '../../../../settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase loginUseCase;

  RegisterCubit(this.loginUseCase) : super(RegisterInitial());

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

    final result = await loginUseCase.call(email, password, name, phone);

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

        if (!context.mounted) return;

        await UserDataCubit.get(context).registerNewUser(loginModel);
        await CacheHelper.saveData(key: 'token', value: loginModel.data!.token);

        token = loginModel.data!.token!;

        if (!context.mounted) return;
        final shopCubit = ShopCubit.get(context);
        shopCubit.currentIndex = 0;
        shopCubit.getProductsData();

        favorites.clear();
        carts.clear();

        navigateAndFinish(context: context, screen: const LayoutScreen());

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
