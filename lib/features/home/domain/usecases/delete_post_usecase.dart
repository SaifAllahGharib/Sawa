import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

@injectable
class DeletePostUseCase implements UseCase<void, String> {
  final IHomeRepository _iHomeRepository;

  DeletePostUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call([String? postId]) async {
    return await _iHomeRepository.deletePost(postId: postId!);
  }
}
