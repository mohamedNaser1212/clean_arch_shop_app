import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../core/widgets/constants.dart';
import '../../../../../core/widgets/end_points.dart';
import '../../../../../core/widgets/reusable_widgets.dart';
import '../../../../../models/login_model.dart';
import '../../../../../screens/layout_screen.dart';
import '../../../domain/use_case/register_use_case/register_use_case.dart';
import '../get_user_data_cubit/get_user_data_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  bool obsecurePassword = true;
  IconData suffixPasswordIcon = Icons.visibility_rounded;
  void changePasswordVisability() {
    obsecurePassword = !obsecurePassword;
    suffixPasswordIcon = obsecurePassword
        ? Icons.visibility_rounded
        : Icons.visibility_off_rounded;
    emit(RegisterChangePasswordVisability());
  }

  final RegisterUseCase registerUseCase;

  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    BuildContext? context,
  }) async {
    emit(RegisterLoadingState());
    var result = await registerUseCase.call(email, password, name, phone);
    result.fold((failure) {
      emit(RegisterErrorState(failure.message));
      print(failure.message);
    }, (loginModel) {
      print('Register Success');
      emit(RegisterSuccessState(loginModel: loginModel));
      UserDataCubit.get(context).registerNewUser(loginModel);
      CacheHelper.saveData(
        key: 'token',
        value: loginModel.data!.token,
      );
      token = loginModel.data!.token!;
      navigateAndFinish(context: context, screen: const LayoutScreen());
      ShopCubit.get(context).currentIndex = 0;
      ShopCubit.get(context).getHomeData();
      favorites.clear();
      carts.clear();
      Fluttertoast.showToast(
        msg: 'Register Success',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
}
