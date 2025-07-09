import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignupInitState extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {
  final User? user;

  SignupSuccessState(this.user);
}

final class SignupFailureState extends SignupState {
  final String error;

  SignupFailureState(this.error);
}
