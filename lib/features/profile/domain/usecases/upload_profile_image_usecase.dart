import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/entities/media_entity.dart';
import '../repository/profile_repository.dart';

@injectable
class UploadProfileImageUseCase implements UseCase<void, MediaEntity> {
  final IProfileRepository _iProfileRepository;

  UploadProfileImageUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call(MediaEntity media) async {
    return await _iProfileRepository.uploadProfileImage(media);
  }
}
