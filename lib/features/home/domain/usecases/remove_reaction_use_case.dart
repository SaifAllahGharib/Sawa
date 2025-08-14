import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';

import '../repositories/home_repository.dart';

@injectable
class RemoveReactionUseCase implements UseCase<void, String> {
  final IHomeRepository _iHomeRepository;

  RemoveReactionUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call([String? postId]) async {
    return await _iHomeRepository.removeReaction(postId: postId!);
  }
}
