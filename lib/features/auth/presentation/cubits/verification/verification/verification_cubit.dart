import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';

import 'verification_state.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final IAuthRepository _iAuthRepository;
  Timer? _timer;
  int _time = 60;

  VerificationCubit(this._iAuthRepository) : super(const VerificationInitial());

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void sendEmailVerification() async {
    _startTimer();

    final result = await _iAuthRepository.sendEmailVerification();

    result.when(
      failure: (_) => emit(const VerificationFailure('send email failed')),
      success: (_) {
        emit(const VerificationCodeSentSuccessOnce());
      },
    );
  }

  void emailVerified() async {
    final result = await _iAuthRepository.emailVerified();

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
