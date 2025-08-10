import 'package:failure_handler/failure_handler.dart';

import '../entity/user_entity.dart';

abstract class IUserRepository {
  FutureResult<void> createUser(UserEntity user);

  FutureResult<UserEntity> getUser(String uId);

  FutureResult<bool> userExists(String uId);

  FutureResult<void> deleteUser(String userId);
}
