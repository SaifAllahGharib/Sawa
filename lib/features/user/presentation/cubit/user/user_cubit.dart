import 'package:bloc/bloc.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/usecase/get_user_use_case.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase _getUserUseCase;

  UserCubit(this._getUserUseCase) : super(const UserInitialState());

  Future<void> getUser(String userId) async {
    final result = await _getUserUseCase(userId);

    result.when(
      failure: (failure) => emit(UserFailureState(failure.code)),
      success: (user) => emit(UserSuccessState(user)),
    );
  }
}
