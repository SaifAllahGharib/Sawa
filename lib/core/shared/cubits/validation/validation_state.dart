import 'package:equatable/equatable.dart';

final class ValidationState extends Equatable {
  final bool? isEmailValid;
  final bool? isPasswordValid;
  final bool enableButton;

  const ValidationState({
    this.isEmailValid,
    this.isPasswordValid,
    this.enableButton = false,
  });

  ValidationState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? enableButton,
  }) {
    return ValidationState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      enableButton: enableButton ?? this.enableButton,
    );
  }

  @override
  List<Object?> get props => [isEmailValid, isPasswordValid, enableButton];
}
