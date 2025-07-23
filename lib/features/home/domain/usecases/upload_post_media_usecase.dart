import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

class UploadPostMediaUseCase extends UseCase<List<String>, MediaEntity> {
  final IHomeRepository _iHomeRepository;

  UploadPostMediaUseCase(this._iHomeRepository);

  @override
  Future<Result<AppFailure, List<String>>> call(MediaEntity mediaEntity) async {
    return await _iHomeRepository.uploadPostMedia(mediaEntity);
  }
}
