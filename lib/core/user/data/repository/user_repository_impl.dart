import 'package:failure_handler/failure_handler.dart';

import '../../../shared/models/result.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _iUserRemoteDataSource;

  UserRepositoryImpl(this._iUserRemoteDataSource);

  @override
  Future<Result<AppFailure, void>> createUser(UserEntity user) async {
    try {
      return Success(
        await _iUserRemoteDataSource.createUser(UserModel.fromEntity(user)),
      );
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, UserEntity>> getUser(String uId) async {
    try {
      final userModel = await _iUserRemoteDataSource.getUser(uId);

      return Success(userModel.toEntity());
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
  Future<Result<AppFailure, void>> deleteUser(String uId) async {
    try {
      return Success(await _iUserRemoteDataSource.deleteUser(uId));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> updateUser(UserEntity user) async {
    try {
      return Success(
        await _iUserRemoteDataSource.updateUser(UserModel.fromEntity(user)),
      );
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
