import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

import '../../../../core/clients/firebase_client.dart';
import '../../../../core/constants/reaction_type.dart';
import '../../../../core/services/storage/i_storage_service.dart';
import '../../../../shared/models/post_media_model.dart';
import '../../../../shared/models/post_model.dart';
import '../../../user/data/model/user_model.dart';
import '../models/create_post_model.dart';
import '../models/reactio_model.dart';
import 'interfaces/i_home_post_remote_data_source.dart';

@LazySingleton(as: IHomePostRemoteDataSource)
class FirebasePostRemoteDataSource implements IHomePostRemoteDataSource {
  final FirebaseClient _firebaseClient;
  final IStorageService _iStorageService;

  FirebasePostRemoteDataSource(this._firebaseClient, this._iStorageService);

  @override
  Future<void> createPost({required CreatePostModel createPostModel}) async {
    final ref = _firebaseClient.db
        .ref()
        .child('posts')
        .child(createPostModel.authorId)
        .push();

    final postId = ref.key;

    await ref.set({
      'id': postId,
      ...createPostModel.copyWith(media: []).toJson(),
    });

    final fileReadFutures = createPostModel.media.map((media) async {
      final file = File(media.path);
      final bytes = await file.readAsBytes();
      return {
        'bytes': bytes,
        'name': p.basename(media.path),
        'type': media.type,
      };
    }).toList();

    final fileData = await Future.wait(fileReadFutures);

    final files = fileData.map((f) => f['bytes'] as Uint8List).toList();
    final fileNames = fileData.map((f) => f['name'] as String).toList();
    final mediaTypes = fileData.map((f) => f['type'] as String).toList();

    try {
      final urls = await _iStorageService.uploadFiles(
        bucket: 'media',
        basePath: 'post_media/${postId.toString()}',
        files: files,
        fileNames: fileNames,
      );

      final mediaRef = _firebaseClient.db
          .ref()
          .child('posts_media')
          .child(postId.toString());

      for (int i = 0; i < urls.length; i++) {
        final newMediaRef = mediaRef.push();
        await newMediaRef.set(
          PostMediaModel(
            id: newMediaRef.key.toString(),
            postId: postId.toString(),
            mediaUrl: urls[i],
            mediaType: mediaTypes[i],
          ).toJson(),
        );
      }
    } catch (e) {
      deletePost(postId: postId.toString());
    }
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await _firebaseClient.db
        .ref()
        .child('posts')
        .child(_firebaseClient.auth.currentUser!.uid)
        .child(postId)
        .remove();
  }

  @override
  Future<List<PostModel>> getUserPosts({required String uId}) async {
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
  Future<List<PostModel>> getDefaultPosts() async {
    final postsRef = _firebaseClient.db.ref().child('posts');

    final postsSnapshot = await postsRef.get();

    if (!postsSnapshot.exists || postsSnapshot.value == null) return [];

    final Map<dynamic, dynamic> usersPostsMap =
        postsSnapshot.value as Map<dynamic, dynamic>;

    final List<PostModel?> postsWithNulls = [];

    for (final userEntry in usersPostsMap.entries) {
      final Map<dynamic, dynamic> postsMap = Map<String, dynamic>.from(
        userEntry.value as Map,
      );

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

        final author = UserModel.fromJson(authorData);

        post = post.copyWith(author: author);

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

  @override
  Future<void> addReaction({
    required String postId,
    required ReactionType type,
  }) async {
    final ref = _firebaseClient.db.ref().child('reactions').child(postId);

    final reactionModel = ReactionModel(
      id: ref.key.toString(),
      postId: postId,
      userId: _firebaseClient.auth.currentUser!.uid,
      type: type.type,
    );

    await ref
        .child(_firebaseClient.auth.currentUser!.uid)
        .set(reactionModel.toJson());
  }

  @override
  Future<void> removeReaction({required String postId}) async {
    final ref = _firebaseClient.db
        .ref()
        .child('reactions')
        .child(postId)
        .child(_firebaseClient.auth.currentUser!.uid);

    await ref.remove();
  }

  @override
  Stream<List<ReactionModel>> getReactions({required String postId}) {
    final ref = _firebaseClient.db.ref().child('reactions').child(postId);

    return ref.onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) {
        return <ReactionModel>[];
      }

      final map = Map<String, dynamic>.from(data as Map);

      return map.entries.map((entry) {
        final value = Map<String, dynamic>.from(entry.value as Map);
        return ReactionModel.fromJson(value);
      }).toList();
    });
  }

  @override
  Stream<ReactionModel?> getUserReaction({required String postId}) {
    final ref = _firebaseClient.db
        .ref()
        .child('reactions')
        .child(postId)
        .child(_firebaseClient.auth.currentUser!.uid);

    return ref.onValue.map((event) {
      if (!event.snapshot.exists) return null;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return ReactionModel.fromJson(data);
    });
  }
}
