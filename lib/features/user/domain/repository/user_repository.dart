import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Result<AppFailure, bool>> createUser(UserEntity user);

  Future<Result<AppFailure, UserEntity?>> getUser(String uId);

  Future<Result<AppFailure, void>> updateUser(UserEntity user);

  Future<Result<AppFailure, void>> deleteUser(String userId);
}
