import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/stream_usecase.dart';
import 'package:sawa/features/home/domain/entities/reaction_entity.dart';

import '../repositories/home_repository.dart';

@injectable
class GetReactionUseCase
    implements StreamUseCase<List<ReactionEntity>, String> {
  final IHomeRepository _iHomeRepository;

  GetReactionUseCase(this._iHomeRepository);

  @override
  StreamResult<List<ReactionEntity>> call(String postId) {
    return _iHomeRepository.getReactions(postId: postId);
  }
}
