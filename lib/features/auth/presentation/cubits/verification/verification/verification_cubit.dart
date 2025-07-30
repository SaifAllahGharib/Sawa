import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/send_email_verification_usercase.dart';

import '../../../../domain/usecases/email_verified_usecase.dart';
import 'verification_state.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final EmailVerifiedUseCase _emailVerifiedUseCase;
  final SendEmailVerificationUserCase _sendEmailVerificationUserCase;
  Timer? _timer;
  int _time = 60;

  VerificationCubit(
    this._emailVerifiedUseCase,
    this._sendEmailVerificationUserCase,
  ) : super(const VerificationInitial());

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void sendEmailVerification() async {
    _startTimer();

    final result = await _sendEmailVerificationUserCase(const NoParams());

    result.when(
      failure: (_) => emit(const VerificationFailure('send email failed')),
      success: (_) {
        emit(const VerificationCodeSentSuccessOnce());
      },
    );
  }

  void emailVerified() async {
    final result = await _emailVerifiedUseCase(const NoParams());

    result.when(
      failure: (failure) => emit(VerificationFailure(failure.code)),
      success: (_) {
        _timer?.cancel();
        _timer = null;
        emit(const VerificationSuccess());
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();

    _time = 60;
    emit(VerificationCodeSent(time: _time, canSend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _time--;
      if (_time > 0) {
        emit(VerificationCodeSent(time: _time, canSend: false));
      } else {
        timer.cancel();
        emit(const VerificationCodeSent(time: 0, canSend: true));
      }
    });
  }
}
