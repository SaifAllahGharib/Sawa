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
  Stream<List<PostModel>> getUserPosts(String uId) async* {
    final ref = _firebaseClient.db.ref().child('posts').child(uId);

    yield* ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final Map<dynamic, dynamic> postsMap = data as Map<dynamic, dynamic>;

      return postsMap.entries.map((entry) {
        final postData = Map<String, dynamic>.from(entry.value);
        return PostModel.fromJson(postData);
      }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
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
