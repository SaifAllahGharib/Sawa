import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';

import '../../../../core/enums/reaction_type.dart';
import '../../../user/domain/entity/user_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/reaction_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/interfaces/i_home_post_remote_data_source.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepositoryImpl implements IHomeRepository {
  final IHomePostRemoteDataSource _iHomePostRemoteDataSource;
  final ErrorHandler _errorHandler;

  HomeRepositoryImpl(this._iHomePostRemoteDataSource, this._errorHandler);

  @override
  FutureResult<void> createPost({
    required CreatePostModel createPostModel,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iHomePostRemoteDataSource.createPost(
        createPostModel: createPostModel,
      ),
    );
  }

  @override
  FutureResult<void> deletePost({required String postId}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iHomePostRemoteDataSource.deletePost(postId: postId),
    );
  }

  @override
  FutureResult<List<PostEntity>> getUserPosts({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iHomePostRemoteDataSource.getUserPosts(uId: uId);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  FutureResult<List<PostEntity>> getDefaultPosts() async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iHomePostRemoteDataSource.getDefaultPosts();
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  FutureResult<void> addReaction({
    required String postId,
    required ReactionType type,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iHomePostRemoteDataSource.addReaction(
        postId: postId,
        type: type,
      ),
    );
  }

  @override
  StreamResult<List<ReactionEntity>> getPostReactions({
    required String postId,
  }) {
    return _errorHandler.handleStreamWithTryCatch(
      () => _iHomePostRemoteDataSource.getPostReactions(postId: postId),
    );
  }

  @override
  StreamResult<ReactionEntity?> getUserPostReaction({required String postId}) {
    return _errorHandler.handleStreamWithTryCatch(
      () => _iHomePostRemoteDataSource.getUserPostReaction(postId: postId),
    );
  }

  @override
  FutureResult<void> removeReaction({required String postId}) {
    return _errorHandler.handleFutureWithTryCatch(
      () => _iHomePostRemoteDataSource.removeReaction(postId: postId),
    );
  }

  @override
  FutureResult<List<UserEntity>> getUsersReactedToPostWithReaction({
    required List<String> uIds,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iHomePostRemoteDataSource
          .getUsersReactedToPostWithReaction(uIds: uIds);

      return response.map((e) => e.toEntity()).toList();
    });
  }
}
