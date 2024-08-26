import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_state.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import '../../../../settings_feature/domain/user_entity/user_entity.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final GetUserInfoUseCase userDataUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.userDataUseCase,
  }) : super(LoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserEntity? userModel;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AppLoginLoadingState());

    final result = await loginUseCase.call(email: email, password: password);
    result.fold(
      (failure) {
        emit(AppLoginErrorState(failure.message));
      },
      (success) async {
        final userDataResult = await userDataUseCase.call();
        userDataResult.fold(
          (failure) {
            emit(AppLoginErrorState(failure.message));
          },
          (userData) {
            userModel = userData;
            emit(AppLoginSuccessState(userData));
          },
        );
      },
    );
  }
}
