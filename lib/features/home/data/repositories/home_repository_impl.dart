import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/home_post_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/media_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/entities/post_media_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_upload_storage_remote_data_source.dart';
import '../models/post_model.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeUploadStorageRemoteDataSource _iHomeUploadStorageRemoteDataSource;
  final IHomePostRemoteDataSource _iHomePostRemoteDataSource;

  HomeRepositoryImpl(
    this._iHomeUploadStorageRemoteDataSource,
    this._iHomePostRemoteDataSource,
  );

  @override
  Future<Result<AppFailure, List<String>>> uploadPostMedia(
    MediaEntity mediaEntity,
  ) async {
    try {
      final response = await _iHomeUploadStorageRemoteDataSource
          .uploadPostMedia(await MediaModel.fromEntity(mediaEntity));
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, String?>> createPost(PostEntity postModel) async {
    try {
      final response = await _iHomePostRemoteDataSource.createPost(
        PostModel.fromEntity(postModel),
      );
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> uploadPostMediaToTable(
    List<PostMediaEntity> mediaModels,
  ) async {
    try {
      final response = await _iHomePostRemoteDataSource.uploadPostMedia(
        mediaModels.map((e) => PostMediaModel.fromEntity(e)).toList(),
      );
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> deletePost(String uId, String postId) async {
    try {
      final response = await _iHomePostRemoteDataSource.deletePost(uId, postId);
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, List<PostEntity>>> getUserPosts(String uId) async {
    try {
      final response = await _iHomePostRemoteDataSource.getUserPosts(uId);

      final listEntities = response.map((e) => e.toEntity()).toList();
      return Success(listEntities);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
