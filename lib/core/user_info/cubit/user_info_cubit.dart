import 'package:bloc/bloc.dart';

import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../domain/use_cases/get_user_info_use_case.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({
    required this.getUserUseCase,
  }) : super(UserInfoState());

  final GetUserInfoUseCase getUserUseCase;

  Future<void> getUserData() async {
    final result = await getUserUseCase.call();
    result.fold(
      (failure) {
        emit(GetUserInfoErrorState(message: failure.toString()));
      },
      (user) {
        emit(GetUserInfoSuccessState(user));
      },
    );
  }
}
