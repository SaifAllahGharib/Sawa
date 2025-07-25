import 'package:failure_handler/src/models/app_failure.dart';

import '../../../shared/models/result.dart';
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
