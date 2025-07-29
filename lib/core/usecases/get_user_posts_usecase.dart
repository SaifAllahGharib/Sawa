import 'dart:async';

import 'package:failure_handler/failure_handler.dart';

import '../../features/home/domain/entities/post_entity.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import 'usecase.dart';

class GetUserPostsUseCase extends UseCase<List<PostEntity>, String> {
  final IHomeRepository _iHomeRepository;

  GetUserPostsUseCase(this._iHomeRepository);

  @override
  FutureOr<Result<AppFailure, List<PostEntity>>> call(String uId) async {
    return await _iHomeRepository.getUserPosts(uId);
  }
}
