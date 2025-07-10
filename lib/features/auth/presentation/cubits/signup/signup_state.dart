import 'package:equatable/equatable.dart';

sealed class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignupInitState extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailureState extends SignupState {
  final String error;

  SignupFailureState(this.error);
}
