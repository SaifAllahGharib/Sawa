import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_model.dart';

import '../../../../core/clients/firebase_client.dart';
import 'home_post_remote_data_source.dart';

class FirebasePostRemoteDataSource implements IHomePostRemoteDataSource {
  final FirebaseClient _firebaseClient;

  FirebasePostRemoteDataSource(this._firebaseClient);

  @override
  Future<String?> createPost(PostModel postModel) async {
    final ref = _firebaseClient.db
        .ref()
        .child('posts')
        .child(postModel.authorId)
        .push();

    final postId = ref.key;

    await ref.set(postModel.copyWith(id: postId).toJson());

    return postId;
  }

  @override
  Future<void> deletePost(String uId, String postId) async {
    await _firebaseClient.db
        .ref()
        .child('posts')
        .child(uId)
        .child(postId)
        .remove();
  }

  @override
  Future<List<PostModel>> getUserPosts(String uId) async {
    final ref = _firebaseClient.db.ref().child('posts').child(uId);
    final snapshot = await ref.get();

    if (!snapshot.exists || snapshot.value == null) return [];

    final Map<dynamic, dynamic> postsMap =
        snapshot.value as Map<dynamic, dynamic>;

    final List<PostModel> posts = await Future.wait(
      postsMap.entries.map((entry) async {
        final postData = Map<String, dynamic>.from(entry.value);
        PostModel post = PostModel.fromJson(postData);

        final mediaSnapshot = await _firebaseClient.db
            .ref()
            .child('posts_media')
            .child(post.id)
            .get();

        if (mediaSnapshot.exists && mediaSnapshot.value != null) {
          final Map<dynamic, dynamic> postsMediaMap =
              mediaSnapshot.value as Map<dynamic, dynamic>;

          final mediaList = postsMediaMap.entries
              .map((e) => Map<String, dynamic>.from(e.value))
              .map((e) => PostMediaModel.fromJson(e))
              .toList();

          post = post.copyWith(media: mediaList);
        }

        return post;
      }),
    );

    posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return posts;
  }

  @override
  Future<void> uploadPostMedia(List<PostMediaModel> mediaModels) async {
    final media = mediaModels.map((e) {
      final ref = _firebaseClient.db
          .ref()
          .child('posts_media')
          .child(e.postId)
          .push();
      return ref.set(e.toJson());
    }).toList();

    await Future.wait(media);
  }
}
