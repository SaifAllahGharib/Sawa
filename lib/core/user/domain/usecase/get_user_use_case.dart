import 'package:failure_handler/failure_handler.dart';

import '../../../usecases/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class GetUserUseCase implements UseCase<UserEntity, String> {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  Future<Result<AppFailure, UserEntity>> call(String uId) async {
    return await _userRepository.getUser(uId);
  }
}
