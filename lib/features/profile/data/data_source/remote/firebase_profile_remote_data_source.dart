import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:sawa/core/services/storage/i_storage_service.dart';
import 'package:sawa/features/profile/data/models/profile_model.dart';
import 'package:sawa/shared/models/media_model.dart';

import '../../../../../core/clients/firebase_client.dart';
import '../../../../../shared/models/post_media_model.dart';
import '../../../../../shared/models/post_model.dart';
import '../../../../user/data/model/user_model.dart';
import 'interface/i_profile_remote_data_source.dart';

@LazySingleton(as: IProfileRemoteDataSource)
class FirebaseProfileRemoteDataSource extends IProfileRemoteDataSource {
  final FirebaseClient _firebaseClient;
  final IStorageService _iStorageService;

  FirebaseProfileRemoteDataSource(this._firebaseClient, this._iStorageService);

  @override
  Future<void> updateProfileName({required String newName}) async {
    return await _firebaseClient.db
        .ref()
        .child('users')
        .child(_firebaseClient.auth.currentUser!.uid)
        .update({'name': newName});
  }

  @override
  Future<ProfileModel> getProfile({required String uId}) async {
    final refs = await Future.wait([
      _firebaseClient.db.ref().child('users').child(uId).get(),
      _firebaseClient.db.ref().child('posts').child(uId).get(),
    ]);

    if (!refs[0].exists || refs[0].value == null) {
      throw Exception('User data not found');
    }

    final userData = refs[0].value;
    final user = UserModel.fromJson(
      Map<String, dynamic>.from(userData as Map? ?? {}),
    );

    if (!refs[1].exists || refs[1].value == null) {
      return ProfileModel(user: user, posts: []);
    }

    final postsData = refs[1].value;
    final postsMap = Map<String, dynamic>.from(postsData as Map? ?? {});

    final posts = await _processPosts(postsMap, user);

    posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return ProfileModel(user: user, posts: posts);
  }

  Future<List<PostModel>> _processPosts(
    Map<String, dynamic> postsMap,
    UserModel user,
  ) async {
    final posts = <PostModel>[];

    for (final entry in postsMap.entries) {
      if (entry.value == null) continue;

      final postData = Map<String, dynamic>.from(entry.value as Map? ?? {});
      if (postData.isEmpty) continue;

      PostModel post = PostModel.fromJson(postData).copyWith(author: user);

      final mediaSnapshot = await _firebaseClient.db
          .ref()
          .child('posts_media')
          .child(post.id)
          .get();

      if (mediaSnapshot.exists && mediaSnapshot.value != null) {
        final mediaData = Map<String, dynamic>.from(
          mediaSnapshot.value as Map? ?? {},
        );

        final mediaList = mediaData.entries
            .map(
              (e) => PostMediaModel.fromJson(
                Map<String, dynamic>.from(e.value as Map? ?? {}),
              ),
            )
            .toList();

        post = post.copyWith(media: mediaList);
      }

      posts.add(post);
    }

    return posts;
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await _firebaseClient.db
        .ref()
        .child('posts')
        .child(_firebaseClient.auth.currentUser!.uid)
        .child(postId)
        .remove();

    await _firebaseClient.db.ref().child('posts_media').child(postId).remove();
  }

  @override
  Future<void> updateProfileBio({required String newBio}) async {
    return await _firebaseClient.db
        .ref()
        .child('users')
        .child(_firebaseClient.auth.currentUser!.uid)
        .update({'bio': newBio});
  }

  @override
  Future<String> updateProfileImage({required MediaModel mediaModel}) async {
    final userId = _firebaseClient.auth.currentUser!.uid;

    final file = File(mediaModel.path);
    final bytes = await file.readAsBytes();

    final fileName = p.basename(file.path);

    final urls = await _iStorageService.uploadFiles(
      bucket: 'media',
      basePath: 'profile_media/$userId',
      files: [bytes],
      fileNames: [fileName],
      overwrite: true,
    );

    await _firebaseClient.db.ref().child('users').child(userId).update({
      'image': urls.first,
    });

    return urls.first;
  }
}
