import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';

import '../../../data/models/login_model.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository _iAuthRepository;

  LoginCubit(this._iAuthRepository) : super(const LoginInitState());

  void login(LoginModel loginModel) async {
    emit(const LoginLoadingState());
    final result = await _iAuthRepository.login(loginModel: loginModel);

    result.when(
      failure: (failure) => emit(LoginFailureState(failure.code)),
      success: (_) => emit(const LoginSuccessState()),
    );
  }
}
