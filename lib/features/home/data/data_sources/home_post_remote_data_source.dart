import '../models/post_media_model.dart';
import '../models/post_model.dart';

abstract class IHomePostRemoteDataSource {
  Future<String?> createPost(PostModel postModel);

  Future<void> deletePost(String uId, String postId);

  Future<void> uploadPostMedia(List<PostMediaModel> mediaModels);

  Stream<List<PostModel>> getUserPosts(String uId);
}
