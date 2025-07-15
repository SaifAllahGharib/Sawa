import 'package:equatable/equatable.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object?> get props => [];
}

final class VerificationInitial extends VerificationState {
  const VerificationInitial();
}

final class VerificationLoading extends VerificationState {
  const VerificationLoading();
}

final class VerificationCodeSentSuccessOnce extends VerificationState {
  const VerificationCodeSentSuccessOnce();
}

final class VerificationCodeSent extends VerificationState {
  final int time;
  final bool canSend;

  const VerificationCodeSent({required this.time, required this.canSend});

  @override
  List<Object?> get props => [time, canSend];
}

final class VerificationSuccess extends VerificationState {
  const VerificationSuccess();
}

final class VerificationFailure extends VerificationState {
  final String errorCode;

  const VerificationFailure(this.errorCode);

  @override
  List<Object?> get props => [errorCode];
}
