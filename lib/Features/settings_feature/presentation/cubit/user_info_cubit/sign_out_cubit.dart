import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/settings_use_case/user_sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final UserSignOutUseCase userSignOutUseCase;

  SignOutCubit({
    required this.userSignOutUseCase,
  }) : super(SignOutState());

  static SignOutCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> signOut() async {
    emit(UserSignOutLoading());

    final result = await userSignOutUseCase.call();

    result.fold(
      (failure) {
        emit(UserSignOutError(error: failure.message));
      },
      (success) {
        emit(UserSignOutSuccess());
      },
    );
  }
}
