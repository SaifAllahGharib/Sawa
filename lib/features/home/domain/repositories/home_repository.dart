import 'package:failure_handler/failure_handler.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';
import 'package:sawa/features/user/domain/entity/user_entity.dart';

import '../../../../core/enums/reaction_type.dart';
import '../entities/post_entity.dart';
import '../entities/reaction_entity.dart';

abstract class IHomeRepository {
  FutureResult<void> createPost({required CreatePostModel createPostModel});

  FutureResult<void> deletePost({required String postId});

  FutureResult<List<PostEntity>> getUserPosts({required String uId});

  FutureResult<List<PostEntity>> getDefaultPosts();

  FutureResult<void> addReaction({
    required String postId,
    required ReactionType type,
  });

  FutureResult<void> removeReaction({required String postId});

  StreamResult<List<ReactionEntity>> getPostReactions({required String postId});

  StreamResult<ReactionEntity?> getUserPostReaction({required String postId});

  FutureResult<List<UserEntity>> getUsersReactedToPostWithReaction({
    required List<String> uIds,
  });
}
