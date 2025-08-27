import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../repository/user_repository.dart';

@injectable
class UserExistsUseCase {
  final IUserRepository _iUserRepository;

  UserExistsUseCase(this._iUserRepository);

  FutureResult<bool> call({required String uId}) async {
    return await _iUserRepository.userExists(uId: uId);
  }
}
