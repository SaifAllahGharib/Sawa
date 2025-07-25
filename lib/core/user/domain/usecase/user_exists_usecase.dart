import 'dart:async';

import 'package:failure_handler/src/models/app_failure.dart';

import '../../../shared/models/result.dart';
import '../../../usecases/usecase.dart';
import '../repository/user_repository.dart';

class UserExistsUseCase extends UseCase<bool, String> {
  final IUserRepository _iUserRepository;

  UserExistsUseCase(this._iUserRepository);

  @override
  FutureOr<Result<AppFailure, bool>> call(String uId) async {
    return await _iUserRepository.userExists(uId);
  }
}
