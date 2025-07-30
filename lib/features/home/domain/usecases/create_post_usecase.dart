import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

import '../entities/post_entity.dart';

@injectable
class CreatePostUseCase implements UseCase<String?, PostEntity> {
  final IHomeRepository _iHomeRepository;

  CreatePostUseCase(this._iHomeRepository);

  @override
  FutureResult<String?> call(PostEntity params) async {
    return await _iHomeRepository.createPost(params);
  }
}
