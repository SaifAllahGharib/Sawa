import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/profile/domain/repository/profile_repository.dart';

@injectable
class ProfileDeletePostUseCase implements UseCase<void, String> {
  final IProfileRepository _iProfileRepository;

  ProfileDeletePostUseCase(this._iProfileRepository);

  @override
  FutureResult<void> call([String? postId]) async {
    return await _iProfileRepository.deletePost(postId: postId!);
  }
}
