import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _iUserRemoteDataSource;

  UserRepositoryImpl(this._iUserRemoteDataSource);

  @override
  Future<Result<AppFailure, bool>> createUser(UserEntity user) async {
    try {
      return Success(
        await _iUserRemoteDataSource.createUser(
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
      final userModel = await _iUserRemoteDataSource.getUser(uId);

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
      return Success(await _iUserRemoteDataSource.userExists(uId));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, bool>> deleteUser(String uId) async {
    try {
      return Success(await _iUserRemoteDataSource.deleteUser(uId));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, bool>> updateUser(UserEntity user) async {
    try {
      return Success(
        await _iUserRemoteDataSource.updateUser(
          UserModel(id: user.id, name: user.name, email: user.email),
        ),
      );
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
