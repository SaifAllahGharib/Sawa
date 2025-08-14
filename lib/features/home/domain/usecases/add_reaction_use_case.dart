import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecases/reaction_params.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class AddReactionUseCase implements UseCase<void, ReactionParams> {
  final IHomeRepository _iHomeRepository;

  AddReactionUseCase(this._iHomeRepository);

  @override
  FutureResult<void> call([ReactionParams? reactionParams]) async {
    return await _iHomeRepository.addReaction(
      postId: reactionParams!.postId,
      type: reactionParams.type,
    );
  }
}
