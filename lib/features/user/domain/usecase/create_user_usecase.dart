import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/user_repository.dart';

@injectable
class CreateUserUseCase implements UseCase<void, UserModel> {
  final IUserRepository _iUserRepository;

  CreateUserUseCase(this._iUserRepository);

  @override
  FutureResult<void> call([UserModel? user]) async {
    return await _iUserRepository.createUser(user: user!);
  }
}
