import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUserCase implements UseCase<void, NoParams> {
  final IAuthRepository _authRepository;

  SendEmailVerificationUserCase(this._authRepository);

  @override
  Future<Result<AppFailure, void>> call(NoParams params) async {
    return await _authRepository.sendEmailVerification();
  }
}
