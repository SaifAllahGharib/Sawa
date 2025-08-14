import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/no_params.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase extends UseCase<void, NoParams> {
  final IAuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  FutureResult<void> call([NoParams? params]) async {
    return await _authRepository.logout();
  }
}
