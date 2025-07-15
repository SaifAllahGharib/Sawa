import 'package:equatable/equatable.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

final class SignupInitState extends SignupState {
  const SignupInitState();

  @override
  List<Object?> get props => [];
}

final class SignupLoadingState extends SignupState {
  const SignupLoadingState();

  @override
  List<Object?> get props => [];
}

final class SignupSuccessState extends SignupState {
  const SignupSuccessState();

  @override
  List<Object?> get props => [];
}

final class SignupFailureState extends SignupState {
  final String code;

  const SignupFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
