import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

@injectable
class CreateUserUseCase implements UseCase<void, UserEntity> {
  final IUserRepository _iUserRepository;

  CreateUserUseCase(this._iUserRepository);

  @override
  FutureResult<void> call(UserEntity user) async {
    return await _iUserRepository.createUser(user);
  }
}
