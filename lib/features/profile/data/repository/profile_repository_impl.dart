import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource _iProfileRemoteDataSource;

  ProfileRepositoryImpl(this._iProfileRemoteDataSource);

  @override
  Future<Result<AppFailure, void>> updateProfileImage(String newName) async {
    // TODO: implement updateProfileImage
    throw UnimplementedError();
  }

  @override
  Future<Result<AppFailure, void>> updateProfileName(String newName) async {
    try {
      final response = await _iProfileRemoteDataSource.updateProfileName(
        newName,
      );
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, ProfileEntity>> getProfile() async {
    try {
      final response = await _iProfileRemoteDataSource.getProfile();
      return Success(response.toEntity());
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
