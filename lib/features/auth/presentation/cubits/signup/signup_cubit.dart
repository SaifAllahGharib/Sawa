import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/user/domain/entity/user_entity.dart';
import 'package:intern_intelligence_social_media_application/core/user/domain/usecase/create_user_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/signup_usecase.dart';

import 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;
  final CreateUserUseCase _createUserUseCase;

  SignupCubit(this._signupUseCase, this._createUserUseCase)
    : super(const SignupInitState());

  void signup(SignupEntity entity) async {
    emit(const SignupLoadingState());
    final result = await _signupUseCase(entity);
    result.when(
      failure: (failure) => emit(SignupFailureState(failure.code)),
      success: (uId) async {
        if (uId != null) {
          final result = await _createUserUseCase(
            UserEntity(id: uId, name: entity.name, email: entity.email),
          );

          result.when(
            failure: (failure) => emit(SignupFailureState(failure.code)),
            success: (success) => emit(const SignupSuccessState()),
          );
        } else {
          emit(const SignupFailureState('failed to create user'));
        }
      },
    );
  }
}
