import 'package:failure_handler/failure_handler.dart';

import '../../../../core/shared/models/result.dart';
import '../entities/media_entity.dart';
import '../entities/post_entity.dart';
import '../entities/post_media_entity.dart';

abstract class IHomeRepository {
  Future<Result<AppFailure, List<String>>> uploadPostMedia(
    MediaEntity mediaEntity,
  );

  Future<Result<AppFailure, String?>> createPost(PostEntity postModel);

  Future<Result<AppFailure, void>> deletePost(String uId, String postId);

  Future<Result<AppFailure, void>> uploadPostMediaToTable(
    List<PostMediaEntity> mediaModels,
  );

  Future<Result<AppFailure, List<PostEntity>>> getUserPosts(String uId);
}
