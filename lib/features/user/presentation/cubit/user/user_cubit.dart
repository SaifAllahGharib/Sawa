import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/get_user_use_case.dart';
import 'user_state.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  final GetUserUseCase _getUserUseCase;

  UserCubit(this._getUserUseCase) : super(const UserInitialState());

  void getUser(String userId) async {
    final result = await _getUserUseCase(uId: userId);

    result.when(
      failure: (failure) => emit(UserFailureState(failure.code)),
      success: (user) => emit(UserSuccessState(user)),
    );
  }
}
