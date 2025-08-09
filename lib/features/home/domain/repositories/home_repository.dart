import 'package:failure_handler/failure_handler.dart';

import '../entities/media_entity.dart';
import '../entities/post_entity.dart';
import '../entities/post_media_entity.dart';

abstract class IHomeRepository {
  FutureResult<List<String>> uploadPostMedia(MediaEntity mediaEntity);

  FutureResult<String?> createPost(PostEntity postModel);

  FutureResult<void> deletePost(String postId);

  FutureResult<void> uploadPostMediaToTable(List<PostMediaEntity> mediaModels);

  FutureResult<List<PostEntity>> getUserPosts(String uId);

  FutureResult<List<PostEntity>> getDefaultPosts();
}
