import 'dart:async';

import 'package:failure_handler/src/models/app_failure.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';

import 'stream_usecase.dart';

class GetUserPostsUseCase extends StreamUseCase<List<PostEntity>, String> {
  final IHomeRepository _iHomeRepository;

  GetUserPostsUseCase(this._iHomeRepository);

  @override
  Stream<Result<AppFailure, List<PostEntity>>> call(String uId) async* {
    yield* _iHomeRepository.getUserPosts(uId);
  }
}
