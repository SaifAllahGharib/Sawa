import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/usecase.dart';
import 'package:sawa/features/user/domain/entity/user_entity.dart';

import '../repositories/home_repository.dart';

@injectable
class GetUsersReactionToPostWithReactions
    implements UseCase<List<UserEntity>, List<String>> {
  final IHomeRepository _homeRepository;

  GetUsersReactionToPostWithReactions(this._homeRepository);

  @override
  FutureResult<List<UserEntity>> call([List<String>? uIds]) async {
    return await _homeRepository.getUsersReactedToPostWithReaction(uIds: uIds!);
  }
}
