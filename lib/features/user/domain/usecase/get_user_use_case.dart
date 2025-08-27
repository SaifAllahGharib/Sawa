import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

@singleton
class GetUserUseCase {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  FutureResult<UserEntity> call({required String uId}) async {
    return await _userRepository.getUser(uId: uId);
  }
}
