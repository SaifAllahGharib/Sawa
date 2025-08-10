import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_local_data_source.dart';
import '../data_source/user_remote_data_source.dart';
import '../model/user_model.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _iUserRemoteDataSource;
  final IUserLocalDataSource _iUserLocalDataSource;
  final ErrorHandler _errorHandler;

  UserRepositoryImpl(
    this._iUserRemoteDataSource,
    this._iUserLocalDataSource,
    this._errorHandler,
  );

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
      final localUser = _iUserLocalDataSource.getUser();
      if (localUser != null) {
        return localUser.toEntity();
      }

      final remoteUser = await _iUserRemoteDataSource.getUser(uId);

      await _iUserLocalDataSource.saveUser(remoteUser);

      return remoteUser.toEntity();
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
}
