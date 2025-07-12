import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginInitState extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccessState extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginFailureState extends LoginState {
  final String code;

  LoginFailureState(this.code);

  @override
  List<Object?> get props => [code];
}
