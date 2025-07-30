import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/post_model.dart';
import 'package:intern_intelligence_social_media_application/core/user/data/model/user_model.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/models/profile_model.dart';

import '../../../../core/clients/firebase_client.dart';
import '../../../home/data/models/post_media_model.dart';
import 'profile_remote_data_source.dart';

@LazySingleton(as: IProfileRemoteDataSource)
class FirebaseProfileRemoteDataSource extends IProfileRemoteDataSource {
  final FirebaseClient _firebaseClient;

  FirebaseProfileRemoteDataSource(this._firebaseClient);

  @override
  Future<void> updateProfileName(String newName) async {
    return await _firebaseClient.db
        .ref()
        .child('users')
        .child(_firebaseClient.auth.currentUser!.uid)
        .update({'name': newName});
  }

  @override
  Future<ProfileModel> getProfile() async {
    final refs = await Future.wait([
      _firebaseClient.db
          .ref()
          .child('users')
          .child(_firebaseClient.auth.currentUser!.uid)
          .get(),
      _firebaseClient.db
          .ref()
          .child('posts')
          .child(_firebaseClient.auth.currentUser!.uid)
          .get(),
    ]);

    final userSnapshot = refs[0].value as Map;
    final postsSnapshot = refs[1].value as Map;
    final user = UserModel.fromJson(Map<String, dynamic>.from(userSnapshot));

    final List<PostModel?> posts = await Future.wait(
      postsSnapshot.entries.map((e) async {
        final postDate = Map<String, dynamic>.from(e.value as Map);
        PostModel post = PostModel.fromJson(postDate);

        post = post.copyWith(author: user);
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

    final finalPosts = posts.whereType<PostModel>().toList();
    finalPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    ProfileModel profile = ProfileModel(user: user, posts: finalPosts);

    return profile;
  }

  @override
  Future<void> uploadProfileImage(String path) async {
    return _firebaseClient.db
        .ref()
        .child('users')
        .child(_firebaseClient.auth.currentUser!.uid)
        .update({'image': path});
  }
}
