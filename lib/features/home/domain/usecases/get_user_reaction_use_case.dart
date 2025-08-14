import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/stream_usecase.dart';
import 'package:sawa/features/home/domain/entities/reaction_entity.dart';

import '../repositories/home_repository.dart';

@injectable
class GetUserReactionUseCase implements StreamUseCase<ReactionEntity?, String> {
  final IHomeRepository _iHomeRepository;

  GetUserReactionUseCase(this._iHomeRepository);

  @override
  StreamResult<ReactionEntity?> call(String postId) {
    return _iHomeRepository.getUserReaction(postId: postId);
  }
}
