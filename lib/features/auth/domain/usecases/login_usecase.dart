import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<void, LoginEntity> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Result<AppFailure, void>> call(LoginEntity params) async {
    return await _authRepository.login(params);
  }
}
