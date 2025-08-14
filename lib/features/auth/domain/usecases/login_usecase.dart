import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/auth/data/models/login_model.dart';
import 'package:sawa/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase implements UseCase<void, LoginModel> {
  final IAuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  FutureResult<void> call([LoginModel? loginModel]) async {
    return await _authRepository.login(loginModel: loginModel!);
  }
}
