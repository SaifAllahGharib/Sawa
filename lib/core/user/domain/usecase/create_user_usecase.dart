import 'dart:async';

import 'package:failure_handler/failure_handler.dart';

import '../../../usecases/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class CreateUserUseCase implements UseCase<void, UserEntity> {
  final IUserRepository _iUserRepository;

  CreateUserUseCase(this._iUserRepository);

  @override
  FutureOr<Result<AppFailure, void>> call(UserEntity user) async {
    return await _iUserRepository.createUser(user);
  }
}
