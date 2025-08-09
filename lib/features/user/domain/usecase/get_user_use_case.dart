import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

@injectable
class GetUserUseCase implements UseCase<UserEntity, String> {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  FutureResult<UserEntity> call(String uId) async {
    return await _userRepository.getUser(uId);
  }
}
