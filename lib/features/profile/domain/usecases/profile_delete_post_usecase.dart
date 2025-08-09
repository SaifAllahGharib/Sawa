import 'package:failure_handler/src/types/future_result.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/repository/profile_repository.dart';

@injectable
class ProfileDeletePostUseCase implements UseCase<void, String> {
  final IProfileRepository _iProfileRepository;

  ProfileDeletePostUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call(String postId) async {
    return await _iProfileRepository.deletePost(postId);
  }
}
