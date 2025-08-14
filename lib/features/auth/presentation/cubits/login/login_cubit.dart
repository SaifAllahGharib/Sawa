import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/login_model.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitState());

  void login(LoginModel loginModel) async {
    emit(const LoginLoadingState());
    final result = await _loginUseCase(loginModel);

    result.when(
      failure: (failure) => emit(LoginFailureState(failure.code)),
      success: (_) => emit(const LoginSuccessState()),
    );
  }
}
