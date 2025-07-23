import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

import '../entities/media_entity.dart';
import '../entities/post_media_entity.dart';

abstract class IHomeRepository {
  Future<Result<AppFailure, List<String>>> uploadPostMedia(
    MediaEntity mediaEntity,
  );

  Future<Result<AppFailure, String?>> createPost(PostEntity postModel);

  Future<Result<AppFailure, bool>> deletePost(String postId);

  Future<Result<AppFailure, bool>> uploadPostMediaToTable(
    List<PostMediaEntity> mediaModels,
  );
}
