import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/profile_repository.dart';

@injectable
class UpdateProfileNameUseCase extends UseCase<void, String> {
  final IProfileRepository _iProfileRepository;

  UpdateProfileNameUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call(String newName) async {
    return await _iProfileRepository.updateProfileName(newName);
  }
}
