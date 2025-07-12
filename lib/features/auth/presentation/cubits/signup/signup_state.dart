import 'package:equatable/equatable.dart';

sealed class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignupInitState extends SignupState {
  @override
  List<Object?> get props => [];
}

final class SignupLoadingState extends SignupState {
  @override
  List<Object?> get props => [];
}

final class SignupSuccessState extends SignupState {
  @override
  List<Object?> get props => [];
}

final class SignupFailureState extends SignupState {
  final String code;

  SignupFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
