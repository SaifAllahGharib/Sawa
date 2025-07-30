import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

@injectable
class UploadPostMediaUseCase extends UseCase<List<String>, MediaEntity> {
  final IHomeRepository _iHomeRepository;

  UploadPostMediaUseCase(this._iHomeRepository);

  @override
  FutureResult<List<String>> call(MediaEntity mediaEntity) async {
    return await _iHomeRepository.uploadPostMedia(mediaEntity);
  }
}
