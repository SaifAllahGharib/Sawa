import 'package:intern_intelligence_social_media_application/features/home/data/models/create_post_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';

abstract class IHomePostRemoteDataSource {
  Future<String?> createPost(CreatePostModel postModel);

  Future<bool> deletePost(String postId);

  Future<bool> uploadPostMedia(List<PostMediaModel> mediaModels);
}
