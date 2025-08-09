import 'package:failure_handler/src/types/future_result.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/no_params.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

@injectable
class GetDefaultPostsUseCase implements UseCase<List<PostEntity>, NoParams> {
  final IHomeRepository _iHomeRepository;

  GetDefaultPostsUseCase(this._iHomeRepository);

  @override
  FutureResult<List<PostEntity>> call(NoParams params) async {
    return await _iHomeRepository.getDefaultPosts();
  }
}
