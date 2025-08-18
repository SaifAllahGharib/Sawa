import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/profile/data/data_source/remote/interface/i_profile_remote_data_source.dart';
import 'package:sawa/features/profile/domain/entity/profile_entity.dart';

import '../../../../shared/models/media_model.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/local/interface/i_profile_local_data_source.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource _iProfileRemoteDataSource;
  final IProfileLocalDataSource _iProfileLocalDataSource;
  final ErrorHandler _errorHandler;

  ProfileRepositoryImpl(
    this._iProfileRemoteDataSource,
    this._iProfileLocalDataSource,
    this._errorHandler,
  );

  @override
  FutureResult<void> updateProfileName({required String newName}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      await _iProfileRemoteDataSource.updateProfileName(newName: newName);
      await _iProfileLocalDataSource.updateProfileName(newName: newName);
    });
  }

  @override
  FutureResult<ProfileEntity> getProfile({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iProfileRemoteDataSource.getProfile(uId: uId);
      return response.toEntity();
    });
  }

  @override
  FutureResult<void> deletePost({required String postId}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iProfileRemoteDataSource.deletePost(postId: postId),
    );
  }

  @override
  FutureResult<void> updateProfileBio({required String newBio}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      await _iProfileRemoteDataSource.updateProfileBio(newBio: newBio);
      await _iProfileLocalDataSource.updateProfileBio(newBio: newBio);
    });
  }

  @override
  FutureResult<void> updateProfileImage({
    required MediaModel mediaModel,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final url = await _iProfileRemoteDataSource.updateProfileImage(
        mediaModel: mediaModel,
      );
      await _iProfileLocalDataSource.updateProfileImage(path: url);
    });
  }
}
