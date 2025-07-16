import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/login_usecase.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitState());

  void login(LoginEntity entity) async {
    emit(const LoginLoadingState());
    final result = await _loginUseCase(entity);

    result.when(
      failure: (failure) => emit(LoginFailureState(failure.code)),
      success: (_) => emit(const LoginSuccessState()),
    );
  }
}
