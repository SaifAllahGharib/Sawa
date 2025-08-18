import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/shared/models/media_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/profile_repository.dart';

@injectable
class UpdateProfileImageUseCase extends UseCase<void, MediaModel> {
  final IProfileRepository _iProfileRepository;

  UpdateProfileImageUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call([MediaModel? mediaModel]) async {
    return await _iProfileRepository.updateProfileImage(
      mediaModel: mediaModel!,
    );
  }
}
