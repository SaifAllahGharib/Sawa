import '../../../../core/utils/enums.dart';
import '../../../../shared/data/models/post_model.dart';
import '../models/post_media_model.dart';
import '../models/reactio_model.dart';

abstract class IHomePostRemoteDataSource {
  Future<String?> createPost(PostModel postModel);

  Future<void> deletePost(String postId);

  Future<void> uploadPostMedia(List<PostMediaModel> mediaModels);

  Future<List<PostModel>> getUserPosts(String uId);

  Future<List<PostModel>> getDefaultPosts();

  Future<void> addReaction({
    required String postId,
    required ReactionType type,
  });

  Future<void> removeReaction({required String postId});

  Stream<List<ReactionModel>> getReactions({required String postId});

  Stream<ReactionModel?> getUserReaction({required String postId});
}
