import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/local/interface/i_user_local_data_source.dart';
import '../data_source/remote/interface/i_user_remote_data_source.dart';
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
  FutureResult<void> createUser({required UserModel user}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iUserRemoteDataSource.createUser(user: user),
    );
  }

  @override
  FutureResult<UserEntity> getUser({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(() async {
      final remoteUser = await _iUserRemoteDataSource.getUser(uId: uId);

      await _iUserLocalDataSource.saveUser(remoteUser);

      return remoteUser.toEntity();
    });
  }

  @override
  FutureResult<bool> userExists({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iUserRemoteDataSource.userExists(uId: uId),
    );
  }

  @override
  FutureResult<void> deleteUser({required String uId}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _iUserRemoteDataSource.deleteUser(uId: uId),
    );
  }
}
