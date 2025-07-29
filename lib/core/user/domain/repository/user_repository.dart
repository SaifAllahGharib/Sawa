import 'package:failure_handler/failure_handler.dart';

import '../entity/user_entity.dart';

abstract class IUserRepository {
  Future<Result<AppFailure, dynamic>> createUser(UserEntity user);

  Future<Result<AppFailure, UserEntity>> getUser(String uId);

  Future<Result<AppFailure, bool>> userExists(String uId);

  Future<Result<AppFailure, dynamic>> updateUser(UserEntity user);

  Future<Result<AppFailure, dynamic>> deleteUser(String userId);
}
