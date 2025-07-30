import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase implements UseCase<void, LoginEntity> {
  final IAuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  FutureResult<void> call(LoginEntity params) async {
    return await _authRepository.login(params);
  }
}
