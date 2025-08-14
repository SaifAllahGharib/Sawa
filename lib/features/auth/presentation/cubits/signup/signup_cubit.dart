import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

import '../../../../user/domain/usecase/create_user_usecase.dart';
import '../../../data/models/signup_model.dart';
import '../../../domain/usecases/signup_usecase.dart';
import 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;
  final CreateUserUseCase _createUserUseCase;

  SignupCubit(this._signupUseCase, this._createUserUseCase)
    : super(const SignupInitState());

  void signup(SignupModel signupModel) async {
    emit(const SignupLoadingState());
    final result = await _signupUseCase(signupModel);
    result.when(
      failure: (failure) => emit(SignupFailureState(failure.code)),
      success: (uId) async {
        if (uId != null) {
          final result = await _createUserUseCase(
            UserModel(
              id: uId,
              name: signupModel.name,
              email: signupModel.identifier,
            ),
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
