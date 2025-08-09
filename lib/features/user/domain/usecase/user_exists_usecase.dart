import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/user_repository.dart';

@injectable
class UserExistsUseCase extends UseCase<bool, String> {
  final IUserRepository _iUserRepository;

  UserExistsUseCase(this._iUserRepository);

  @override
  FutureResult<bool> call(String uId) async {
    return await _iUserRepository.userExists(uId);
  }
}
