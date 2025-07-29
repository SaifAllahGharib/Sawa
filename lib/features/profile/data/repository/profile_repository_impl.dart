import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_upload_storage_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/shared/models/media_model.dart';
import '../../domain/repository/profile_repository.dart';

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
  Future<Result<AppFailure, void>> updateProfileName(String newName) async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _iProfileRemoteDataSource.updateProfileName(newName),
    );
  }

  @override
  Future<Result<AppFailure, ProfileEntity>> getProfile() async {
    return _errorHandler.handleFutureWithTryCatch<ProfileEntity>(() async {
      final response = await _iProfileRemoteDataSource.getProfile();
      return response.toEntity();
    });
  }

  @override
  Future<Result<AppFailure, void>> uploadProfileImage(MediaEntity media) async {
    return _errorHandler.handleFutureWithTryCatch<void>(() async {
      final path = await _iProfileUploadStorageRemoteDataSource
          .uploadProfileImage(await MediaModel.fromEntity(media));
      return await _iProfileRemoteDataSource.uploadProfileImage(path);
    });
  }
}
