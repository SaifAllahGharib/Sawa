import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/post/data/models/comment_request_model.dart';

import '../../../../core/enums/reaction_type.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/reaction_entity.dart';
import '../../domain/repositories/i_post_repository.dart';
import '../data_sources/interface/i_post_remote_data_source.dart';
import '../models/create_post_model.dart';

@LazySingleton(as: IPostRepository)
class PostRepositoryImpl implements IPostRepository {
  final IPostRemoteDataSource _iPostRemoteDataSource;
  final ErrorHandler _errorHandler;

  PostRepositoryImpl(this._iPostRemoteDataSource, this._errorHandler);

  @override
  FutureResult<void> createPost({
    required CreatePostModel createPostModel,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iPostRemoteDataSource.createPost(
        createPostModel: createPostModel,
      ),
    );
  }

  @override
  FutureResult<void> deletePost({required String postId}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iPostRemoteDataSource.deletePost(postId: postId),
    );
  }

  @override
  FutureResult<List<PostEntity>> getUserPosts({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iPostRemoteDataSource.getUserPosts(uId: uId);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  FutureResult<List<PostEntity>> getDefaultPosts() async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iPostRemoteDataSource.getDefaultPosts();
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  FutureResult<void> addReaction({
    required String postId,
    required ReactionType type,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _iPostRemoteDataSource.addReaction(postId: postId, type: type),
    );
  }

  @override
  StreamResult<List<ReactionEntity>> getPostReactions({
    required String postId,
  }) {
    return _errorHandler.handleStreamWithTryCatch(
      () => _iPostRemoteDataSource.getPostReactions(postId: postId),
    );
  }

  @override
  StreamResult<ReactionEntity?> getUserPostReaction({required String postId}) {
    return _errorHandler.handleStreamWithTryCatch(
      () => _iPostRemoteDataSource.getUserPostReaction(postId: postId),
    );
  }

  @override
  FutureResult<void> removeReaction({required String postId}) {
    return _errorHandler.handleFutureWithTryCatch(
      () => _iPostRemoteDataSource.removeReaction(postId: postId),
    );
  }

  @override
  FutureResult<List<UserEntity>> getUsersReactedToPostWithReaction({
    required List<String> uIds,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iPostRemoteDataSource
          .getUsersReactedToPostWithReaction(uIds: uIds);

      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  FutureResult<void> addComment({required CommentRequestModel comment}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iPostRemoteDataSource.addComment(comment: comment),
    );
  }
}
