import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/post_model.dart';
import 'package:intern_intelligence_social_media_application/core/user/data/model/user_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';

import '../../../../core/clients/firebase_client.dart';
import 'home_post_remote_data_source.dart';

@LazySingleton(as: IHomePostRemoteDataSource)
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
  Future<void> deletePost(String postId) async {
    await _firebaseClient.db
        .ref()
        .child('posts')
        .child(_firebaseClient.auth.currentUser!.uid)
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

    final List<PostModel?> postsWithNulls = await Future.wait(
      postsMap.entries.map((entry) async {
        final postData = Map<String, dynamic>.from(entry.value);
        PostModel post = PostModel.fromJson(postData);

        final author = await _firebaseClient.db
            .ref()
            .child('users')
            .child(post.authorId)
            .get();

        if (!author.exists && author.value != null) {
          return null;
        }

        final finalAuthor = Map<String, dynamic>.from(author.value as Map);

        post = post.copyWith(author: UserModel.fromJson(finalAuthor));

        final mediaSnapshot = await _firebaseClient.db
            .ref()
            .child('posts_media')
            .child(post.id)
            .get();

        if (mediaSnapshot.exists && mediaSnapshot.value != null) {
          final postsMediaMap = Map<String, dynamic>.from(
            mediaSnapshot.value as Map,
          );

          final mediaList = postsMediaMap.entries
              .map(
                (e) => PostMediaModel.fromJson(
                  Map<String, dynamic>.from(e.value as Map),
                ),
              )
              .toList();

          post = post.copyWith(media: mediaList);
        }

        return post;
      }),
    );

    final posts = postsWithNulls.whereType<PostModel>().toList();
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

  @override
  Future<List<PostModel>> getDefaultPosts() async {
    final postsRef = _firebaseClient.db.ref().child('posts');

    final postsSnapshot = await postsRef.get();

    if (!postsSnapshot.exists || postsSnapshot.value == null) return [];

    final Map<dynamic, dynamic> usersPostsMap =
        postsSnapshot.value as Map<dynamic, dynamic>;

    final List<PostModel?> postsWithNulls = [];

    for (final userEntry in usersPostsMap.entries) {
      final Map<dynamic, dynamic> postsMap =
          userEntry.value as Map<dynamic, dynamic>;

      for (final postEntry in postsMap.entries) {
        final postData = Map<String, dynamic>.from(postEntry.value);
        PostModel post = PostModel.fromJson(postData);

        final authorSnapshot = await _firebaseClient.db
            .ref()
            .child('users')
            .child(post.authorId)
            .get();

        if (!authorSnapshot.exists || authorSnapshot.value == null) {
          continue;
        }

        final authorData = Map<String, dynamic>.from(
          authorSnapshot.value as Map<dynamic, dynamic>,
        );
        post = post.copyWith(author: UserModel.fromJson(authorData));

        final mediaSnapshot = await _firebaseClient.db
            .ref()
            .child('posts_media')
            .child(post.id)
            .get();

        if (mediaSnapshot.exists && mediaSnapshot.value != null) {
          final mediaMap = Map<String, dynamic>.from(
            mediaSnapshot.value as Map<dynamic, dynamic>,
          );

          final mediaList = mediaMap.entries
              .map(
                (e) =>
                    PostMediaModel.fromJson(Map<String, dynamic>.from(e.value)),
              )
              .toList();

          post = post.copyWith(media: mediaList);
        }

        postsWithNulls.add(post);
      }
    }

    final posts = postsWithNulls.whereType<PostModel>().toList();
    posts.shuffle();

    return posts;
  }
}
