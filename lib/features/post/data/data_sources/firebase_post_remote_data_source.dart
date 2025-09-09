import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:sawa/features/post/data/models/comment_response_model.dart';

import '../../../../core/clients/firebase_client.dart';
import '../../../../core/enums/reaction_type.dart';
import '../../../../core/services/storage/i_storage_service.dart';
import '../../../user/data/model/user_model.dart';
import '../models/comment_request_model.dart';
import '../models/create_post_model.dart';
import '../models/post_media_model.dart';
import '../models/post_model.dart';
import '../models/reactio_model.dart';
import 'interface/i_post_remote_data_source.dart';

@LazySingleton(as: IPostRemoteDataSource)
class FirebasePostRemoteDataSource implements IPostRemoteDataSource {
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
    final [postsSnapshot, usersSnapshot, mediaSnapshot] = await Future.wait([
      _firebaseClient.db.ref().child('posts').get(),
      _firebaseClient.db.ref().child('users').get(),
      _firebaseClient.db.ref().child('posts_media').get(),
    ]);

    if (!postsSnapshot.exists || postsSnapshot.value == null) return [];

    final allPostsMap = _convertToMap(postsSnapshot.value);
    final allUsersMap = usersSnapshot.exists
        ? _convertToMap(usersSnapshot.value)
        : <String, dynamic>{};
    final allMediaMap = mediaSnapshot.exists
        ? _convertToMap(mediaSnapshot.value)
        : <String, dynamic>{};

    final posts = await _processAllPosts(allPostsMap, allUsersMap, allMediaMap);

    posts.shuffle();

    return posts;
  }

  Future<List<PostModel>> _processAllPosts(
    Map<String, dynamic> allPostsMap,
    Map<String, dynamic> allUsersMap,
    Map<String, dynamic> allMediaMap,
  ) async {
    final posts = <PostModel>[];
    final futures = <Future>[];

    for (final userEntry in allPostsMap.entries) {
      final userPostsMap = _convertToMap(userEntry.value);

      for (final postEntry in userPostsMap.entries) {
        final postJson = _convertToMap(postEntry.value);
        final postId = postJson['id']?.toString();
        final authorId = postJson['user_id']?.toString();

        if (postId == null || authorId == null) continue;

        futures.add(
          _processSinglePost(
            postJson,
            authorId,
            postId,
            allUsersMap,
            allMediaMap,
          ).then(posts.add),
        );
      }
    }

    await Future.wait(futures);
    return posts;
  }

  Future<PostModel> _processSinglePost(
    Map<String, dynamic> postJson,
    String authorId,
    String postId,
    Map<String, dynamic> allUsersMap,
    Map<String, dynamic> allMediaMap,
  ) async {
    final basePost = PostModel.fromJson({
      ...postJson,
      'media': [],
      'author': UserModel.empty().toJson(),
    });

    final authorData = allUsersMap[authorId] != null
        ? UserModel.fromJson(_convertToMap(allUsersMap[authorId]))
        : UserModel.empty();

    final media = await _processMedia(_convertToMap(allMediaMap[postId]));

    return basePost.copyWith(author: authorData, media: media);
  }

  Future<List<PostMediaModel>> _processMedia(
    Map<String, dynamic> mediaMap,
  ) async {
    if (mediaMap.isEmpty) return [];

    return mediaMap.entries
        .map((e) => PostMediaModel.fromJson(_convertToMap(e.value)))
        .where((media) => media.mediaUrl.isNotEmpty)
        .toList();
  }

  Map<String, dynamic> _convertToMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return {};
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
  Stream<List<ReactionModel>> getPostReactions({required String postId}) {
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
  Stream<ReactionModel?> getUserPostReaction({required String postId}) {
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

  @override
  Future<List<UserModel>> getUsersReactedToPostWithReaction({
    required List<String> uIds,
  }) async {
    final List<Future<DataSnapshot>> futureList = [];

    for (final userId in uIds) {
      futureList.add(
        _firebaseClient.db.ref().child('users').child(userId).get(),
      );
    }

    return await Future.wait(futureList).then((snapshots) {
      return snapshots.map((snapshot) {
        if (!snapshot.exists || snapshot.value == null) {
          return UserModel.empty();
        }

        final userData = Map<String, dynamic>.from(snapshot.value as Map);
        return UserModel.fromJson(userData);
      }).toList();
    });
  }

  @override
  Future<void> addComment({required CommentRequestModel comment}) async {
    final ref = _firebaseClient.db
        .ref()
        .child('comments')
        .child(comment.postId)
        .push();

    final commentId = ref.key;
    final userId = _firebaseClient.auth.currentUser!.uid;

    final commentData = {
      'id': commentId,
      'postId': comment.postId,
      'userId': userId,
      'content': comment.content,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };

    await ref.set(commentData);
  }

  @override
  Future<List<CommentResponseModel>> getComments({
    required String postId,
  }) async {
    final ref = _firebaseClient.db.ref().child('comments').child(postId);
    final snapshot = await ref.get();

    if (!snapshot.exists || snapshot.value == null) return [];

    final commentsMap = Map<String, dynamic>.from(snapshot.value as Map);

    final comments = await Future.wait(
      commentsMap.entries.map((entry) async {
        final commentData = Map<String, dynamic>.from(entry.value as Map);

        final userSnapshot = await _firebaseClient.db
            .ref()
            .child('users')
            .child(commentData['userId'])
            .get();

        UserModel user = UserModel.empty();
        if (userSnapshot.exists && userSnapshot.value != null) {
          user = UserModel.fromJson(
            Map<String, dynamic>.from(userSnapshot.value as Map),
          );
        }

        return CommentResponseModel(
          id: commentData['id'] as String,
          userId: commentData['userId'] as String,
          user: user,
          postId: commentData['postId'] as String,
          content: commentData['content'] as String,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            commentData['createdAt'] as int,
          ),
        );
      }),
    );

    comments.sort((a, b) {
      final aTime = (commentsMap[a.id]['createdAt'] ?? 0) as int;
      final bTime = (commentsMap[b.id]['createdAt'] ?? 0) as int;
      return bTime.compareTo(aTime);
    });

    return comments;
  }
}
