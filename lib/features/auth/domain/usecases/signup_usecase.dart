import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';

import '../repositories/auth_repository.dart';

@injectable
class SignupUseCase implements UseCase<String?, SignupEntity> {
  final IAuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  @override
  FutureResult<String?> call(SignupEntity params) async {
    return await _authRepository.createAccount(params);
  }
}
