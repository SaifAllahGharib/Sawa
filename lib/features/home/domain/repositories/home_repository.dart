import 'package:failure_handler/failure_handler.dart';

import '../../../../core/utils/enums.dart';
import '../entities/media_entity.dart';
import '../entities/post_entity.dart';
import '../entities/post_media_entity.dart';
import '../entities/reaction_entity.dart';

abstract class IHomeRepository {
  FutureResult<List<String>> uploadPostMedia(MediaEntity mediaEntity);

  FutureResult<String?> createPost(PostEntity postModel);

  FutureResult<void> deletePost(String postId);

  FutureResult<void> uploadPostMediaToTable(List<PostMediaEntity> mediaModels);

  FutureResult<List<PostEntity>> getUserPosts(String uId);

  FutureResult<List<PostEntity>> getDefaultPosts();

  FutureResult<void> addReaction({
    required String postId,
    required ReactionType type,
  });

  FutureResult<void> removeReaction({required String postId});

  StreamResult<List<ReactionEntity>> getReactions({required String postId});

  StreamResult<ReactionEntity?> getUserReaction({required String postId});
}
