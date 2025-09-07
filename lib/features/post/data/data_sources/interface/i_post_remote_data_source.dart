import '../../../../../core/enums/reaction_type.dart';
import '../../../../user/data/model/user_model.dart';
import '../../models/comment_request_model.dart';
import '../../models/create_post_model.dart';
import '../../models/post_model.dart';
import '../../models/reactio_model.dart';

abstract class IPostRemoteDataSource {
  Future<void> createPost({required CreatePostModel createPostModel});

  Future<void> deletePost({required String postId});

  Future<List<PostModel>> getUserPosts({required String uId});

  Future<List<PostModel>> getDefaultPosts();

  Future<void> addReaction({
    required String postId,
    required ReactionType type,
  });

  Future<void> removeReaction({required String postId});

  Stream<List<ReactionModel>> getPostReactions({required String postId});

  Stream<ReactionModel?> getUserPostReaction({required String postId});

  Future<List<UserModel>> getUsersReactedToPostWithReaction({
    required List<String> uIds,
  });

  Future<void> addComment({required CommentRequestModel comment});
}
