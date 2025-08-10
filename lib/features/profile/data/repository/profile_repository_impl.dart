import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_upload_storage_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

import '../../../../shared/data/models/media_model.dart';
import '../../domain/repository/profile_repository.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource _iProfileRemoteDataSource;
  final IProfileUploadStorageRemoteDataSource
  _iProfileUploadStorageRemoteDataSource;
  final ErrorHandler _errorHandler;

  ProfileRepositoryImpl(
    this._iProfileRemoteDataSource,
    this._iProfileUploadStorageRemoteDataSource,
    this._errorHandler,
  );

  @override
  FutureResult<void> updateProfileName(String newName) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iProfileRemoteDataSource.updateProfileName(newName),
    );
  }

  @override
  FutureResult<ProfileEntity> getProfile(String uId) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iProfileRemoteDataSource.getProfile(uId);
      return response.toEntity();
    });
  }

  @override
  FutureResult<void> uploadProfileImage(MediaEntity media) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final path = await _iProfileUploadStorageRemoteDataSource
          .uploadProfileImage(await MediaModel.fromEntity(media));
      return await _iProfileRemoteDataSource.uploadProfileImage(path);
    });
  }

  @override
  FutureResult<void> deletePost(String postId) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      return await _iProfileRemoteDataSource.deletePost(postId);
    });
  }

  @override
  FutureResult<void> updateProfileBio(String newBio) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      return await _iProfileRemoteDataSource.updateProfileBio(newBio);
    });
  }
}
