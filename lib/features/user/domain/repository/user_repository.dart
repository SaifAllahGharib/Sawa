import 'package:failure_handler/failure_handler.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

import '../entity/user_entity.dart';

abstract class IUserRepository {
  FutureResult<void> createUser({required UserModel user});

  FutureResult<UserEntity> getUser({required String uId});

  FutureResult<bool> userExists({required String uId});

  FutureResult<void> deleteUser({required String uId});
}
