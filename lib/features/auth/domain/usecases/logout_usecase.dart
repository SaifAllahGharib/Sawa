import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase extends UseCase<void, NoParams> {
  final IAuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  FutureResult<void> call(NoParams params) async {
    return await _authRepository.logout();
  }
}
