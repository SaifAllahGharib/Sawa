import 'package:failure_handler/failure_handler.dart';

import '../entity/user_entity.dart';

abstract class IUserRepository {
  FutureResult<dynamic> createUser(UserEntity user);

  FutureResult<UserEntity> getUser(String uId);

  FutureResult<bool> userExists(String uId);

  FutureResult<dynamic> updateUser(UserEntity user);

  FutureResult<dynamic> deleteUser(String userId);
}
