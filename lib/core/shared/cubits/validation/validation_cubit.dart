import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';
import 'package:intern_intelligence_social_media_application/core/utils/validators.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(const ValidationState());

  void validateEmail(String email) {
    emit(state.copyWith(isEmailValid: emailValidator(email)));
    _enableButton();
  }

  void validatePassword(String password) {
    emit(state.copyWith(isPasswordValid: passwordValidator(password)));
    _enableButton();
  }

  void _enableButton() {
    emit(
      state.copyWith(
        enableButton: state.isEmailValid! && state.isPasswordValid!,
      ),
    );
  }
}
