import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/profile_repository.dart';

@injectable
class UpdateProfileBioUseCase extends UseCase<void, String> {
  final IProfileRepository _iProfileRepository;

  UpdateProfileBioUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call([String? newBio]) async {
    return await _iProfileRepository.updateProfileBio(newBio: newBio!);
  }
}
