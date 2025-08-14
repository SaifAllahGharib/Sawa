import 'package:sawa/features/home/data/models/create_post_model.dart';

import '../../../../../core/constants/reaction_type.dart';
import '../../../../../shared/models/post_model.dart';
import '../../models/reactio_model.dart';

abstract class IHomePostRemoteDataSource {
  Future<void> createPost({required CreatePostModel createPostModel});

  Future<void> deletePost({required String postId});

  Future<List<PostModel>> getUserPosts({required String uId});

  Future<List<PostModel>> getDefaultPosts();

  Future<void> addReaction({
    required String postId,
    required ReactionType type,
  });

  Future<void> removeReaction({required String postId});

  Stream<List<ReactionModel>> getReactions({required String postId});

  Stream<ReactionModel?> getUserReaction({required String postId});
}
