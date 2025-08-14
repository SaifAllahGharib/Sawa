import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/auth/data/models/signup_model.dart';

import '../repositories/auth_repository.dart';

@injectable
class SignupUseCase implements UseCase<String?, SignupModel> {
  final IAuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  @override
  FutureResult<String?> call([SignupModel? signupModel]) async {
    return await _authRepository.createAccount(signupModel: signupModel!);
  }
}
