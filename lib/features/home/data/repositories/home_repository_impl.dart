import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/home_post_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';

import '../../../../core/shared/models/post_model.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/post_media_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_upload_storage_remote_data_source.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeUploadStorageRemoteDataSource _iHomeUploadStorageRemoteDataSource;
  final IHomePostRemoteDataSource _iHomePostRemoteDataSource;
  final ErrorHandler _errorHandler;

  HomeRepositoryImpl(
    this._iHomeUploadStorageRemoteDataSource,
    this._iHomePostRemoteDataSource,
    this._errorHandler,
  );

  @override
  Future<Result<AppFailure, List<String>>> uploadPostMedia(
    MediaEntity mediaEntity,
  ) async {
    return _errorHandler.handleFutureWithTryCatch<List<String>>(
      () async => await _iHomeUploadStorageRemoteDataSource.uploadPostMedia(
        await MediaModel.fromEntity(mediaEntity),
      ),
    );
  }

  @override
  Future<Result<AppFailure, String?>> createPost(PostEntity post) async {
    return _errorHandler.handleFutureWithTryCatch<String?>(
      () async => await _iHomePostRemoteDataSource.createPost(
        PostModel.fromEntity(post),
      ),
    );
  }

  @override
  Future<Result<AppFailure, void>> uploadPostMediaToTable(
    List<PostMediaEntity> mediaModels,
  ) async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _iHomePostRemoteDataSource.uploadPostMedia(
        mediaModels.map((e) => PostMediaModel.fromEntity(e)).toList(),
      ),
    );
  }

  @override
  Future<Result<AppFailure, void>> deletePost(String uId, String postId) async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _iHomePostRemoteDataSource.deletePost(uId, postId),
    );
  }

  @override
  Future<Result<AppFailure, List<PostEntity>>> getUserPosts(String uId) async {
    return _errorHandler.handleFutureWithTryCatch<List<PostEntity>>(() async {
      final response = await _iHomePostRemoteDataSource.getUserPosts(uId);
      return response.map((e) => e.toEntity()).toList();
    });
  }
}
