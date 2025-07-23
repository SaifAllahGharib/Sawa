import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

class CreatePostUseCase implements UseCase<String?, PostEntity> {
  final IHomeRepository _iHomeRepository;

  CreatePostUseCase(this._iHomeRepository);

  @override
  Future<Result<AppFailure, String?>> call(PostEntity params) async {
    return await _iHomeRepository.createPost(params);
  }
}
