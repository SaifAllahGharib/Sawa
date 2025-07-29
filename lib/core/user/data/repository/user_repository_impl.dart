import 'package:failure_handler/failure_handler.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _iUserRemoteDataSource;
  final ErrorHandler _errorHandler;

  UserRepositoryImpl(this._iUserRemoteDataSource, this._errorHandler);

  @override
  Future<Result<AppFailure, void>> createUser(UserEntity user) async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async =>
          await _iUserRemoteDataSource.createUser(UserModel.fromEntity(user)),
    );
  }

  @override
  Future<Result<AppFailure, UserEntity>> getUser(String uId) async {
    return _errorHandler.handleFutureWithTryCatch<UserEntity>(() async {
      final response = await _iUserRemoteDataSource.getUser(uId);
      return response.toEntity();
    });
  }

  @override
  Future<Result<AppFailure, bool>> userExists(String uId) async {
    return _errorHandler.handleFutureWithTryCatch<bool>(
      () async => await _iUserRemoteDataSource.userExists(uId),
    );
  }

  @override
  Future<Result<AppFailure, void>> deleteUser(String uId) async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _iUserRemoteDataSource.deleteUser(uId),
    );
  }

  @override
  Future<Result<AppFailure, void>> updateUser(UserEntity user) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _iUserRemoteDataSource.updateUser(UserModel.fromEntity(user)),
    );
  }
}
