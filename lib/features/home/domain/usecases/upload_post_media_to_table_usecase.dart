import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_media_entity.dart';

import '../repositories/home_repository.dart';

class UploadPostMediaToTableUseCase
    implements UseCase<bool, List<PostMediaEntity>> {
  final IHomeRepository _iHomeRepository;

  UploadPostMediaToTableUseCase(this._iHomeRepository);

  @override
  Future<Result<AppFailure, bool>> call(List<PostMediaEntity> params) async {
    return await _iHomeRepository.uploadPostMediaToTable(params);
  }
}
