import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<AppFailure, bool>> createUser(UserEntity user) async {
    try {
      return Success(
        await _remoteDataSource.createUser(
          UserModel(id: user.id, name: user.name, email: user.email),
        ),
      );
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, UserEntity?>> getUser(String uId) async {
    try {
      final userModel = await _remoteDataSource.getUser(uId);

      return Success(
        userModel != null
            ? UserEntity(
                id: userModel.id,
                name: userModel.name,
                email: userModel.email,
              )
            : null,
      );
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, bool>> userExists(String uId) async {
    try {
      return Success(await _remoteDataSource.userExists(uId));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Result<AppFailure, void>> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
