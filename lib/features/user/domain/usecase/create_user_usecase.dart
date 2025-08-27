import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

import '../repository/user_repository.dart';

@injectable
class CreateUserUseCase {
  final IUserRepository _iUserRepository;

  CreateUserUseCase(this._iUserRepository);

  FutureResult<void> call({required UserModel user}) async {
    return await _iUserRepository.createUser(user: user);
  }
}
