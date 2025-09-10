import 'package:failure_handler/failure_handler.dart';
import 'package:sawa/features/post/domain/entities/comment_response_entity.dart';

import '../../../../core/enums/reaction_type.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../data/models/comment_request_model.dart';
import '../../data/models/create_post_model.dart';
import '../entities/post_entity.dart';
import '../entities/reaction_entity.dart';

abstract class IPostRepository {
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

  FutureResult<void> addComment({required CommentRequestModel comment});

  FutureResult<List<CommentResponseEntity>> getComments({
    required String postId,
  });

  FutureResult<void> addReactionToComment({
    required String commentId,
    required ReactionType type,
  });

  FutureResult<void> removeReactionFromComment({required String commentId});

  StreamResult<List<ReactionEntity>> getCommentReactions({
    required String commentId,
  });

  StreamResult<ReactionEntity?> getUserCommentReaction({
    required String commentId,
  });
}
