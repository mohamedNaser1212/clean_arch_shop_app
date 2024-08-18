import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/authentication_use_case.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';

import '../../../../../core/utils/screens/widgets/cache_helper.dart';
import '../../../../../core/utils/screens/widgets/constants.dart';
import '../../../../../core/utils/screens/widgets/reusable_widgets.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../home/presentation/screens/layout_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(AppInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  AuthenticationUseCase? loginUseCase;

  Future<void> userLogin({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    emit(AppLoginLoadingState());

    var result = await loginUseCase?.call(email, password);
    if (!context!.mounted) return;
    ShopCubit.get(context).currentIndex = 0;
    result?.fold(
      (failure) {
        emit(AppLoginErrorState(failure.message));
        print(failure.message);
      },
      (loginModel) async {
        print('Login Success');
        emit(AppLoginSuccessState(loginModel));

        Fluttertoast.showToast(
          msg: loginModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        token = loginModel.data!.token!;
        await CacheHelper.saveData(key: 'token', value: token);
        print(token);
        ShopCubit.get(context).getHomeData();
        ShopCubit.get(context).getCartItems();
        ShopCubit.get(context).getFavorites();
        navigateAndFinish(context: context, screen: const LayoutScreen());
      },
    );
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(AppLoginLoadingState());
  //   DioHelper.postData(
  //     url: loginEndPoint,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //     token: token,
  //   ).then((value) {
  //     print(value.data);
  //     loginModel = LoginModel.fromJson(value.data);
  //     print(loginModel!.message);
  //     print(loginModel!.status);
  //     //print(loginModel!.data!.token);
  //     emit(AppLoginSuccessState(
  //       loginModel!,
  //     ));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
