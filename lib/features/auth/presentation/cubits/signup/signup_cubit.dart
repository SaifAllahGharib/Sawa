import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

import '../../../../user/domain/usecase/create_user_usecase.dart';
import '../../../data/models/signup_model.dart';
import 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final IAuthRepository _iAuthRepository;
  final CreateUserUseCase _createUserUseCase;

  SignupCubit(this._iAuthRepository, this._createUserUseCase)
    : super(const SignupInitState());

  void signup(SignupModel signupModel) async {
    emit(const SignupLoadingState());
    final result = await _iAuthRepository.createAccount(
      signupModel: signupModel,
    );
    result.when(
      failure: (failure) => emit(SignupFailureState(failure.code)),
      success: (uId) async {
        if (uId != null) {
          final result = await _createUserUseCase(
            user: UserModel(
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
