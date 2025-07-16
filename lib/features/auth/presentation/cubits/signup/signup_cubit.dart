import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/signup_usecase.dart';

import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupCubit(this._signupUseCase) : super(const SignupInitState());

  void signup(SignupEntity entity) async {
    emit(const SignupLoadingState());
    final result = await _signupUseCase(entity);
    result.when(
      failure: (failure) => emit(SignupFailureState(failure.code)),
      success: (_) => emit(const SignupSuccessState()),
    );
  }
}
