import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/user_model.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _iUserRemoteDataSource;
  final ErrorHandler _errorHandler;

  UserRepositoryImpl(this._iUserRemoteDataSource, this._errorHandler);

  @override
  FutureResult<void> createUser(UserEntity user) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _iUserRemoteDataSource.createUser(UserModel.fromEntity(user)),
    );
  }

  @override
  FutureResult<UserEntity> getUser(String uId) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final response = await _iUserRemoteDataSource.getUser(uId);
      return response.toEntity();
    });
  }

  @override
  FutureResult<bool> userExists(String uId) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iUserRemoteDataSource.userExists(uId),
    );
  }

  @override
  FutureResult<void> deleteUser(String uId) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iUserRemoteDataSource.deleteUser(uId),
    );
  }

  @override
  FutureResult<void> updateUser(UserEntity user) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _iUserRemoteDataSource.updateUser(UserModel.fromEntity(user)),
    );
  }
}
