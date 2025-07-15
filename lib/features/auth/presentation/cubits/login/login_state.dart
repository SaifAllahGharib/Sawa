import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitState extends LoginState {
  const LoginInitState();

  @override
  List<Object?> get props => [];
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();

  @override
  List<Object?> get props => [];
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState();

  @override
  List<Object?> get props => [];
}

final class LoginFailureState extends LoginState {
  final String code;

  const LoginFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
