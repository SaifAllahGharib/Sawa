import 'package:intern_intelligence_social_media_application/core/shared/models/user_model.dart';

abstract class DbApi {
  Future<void> setUser(UserModel user);

  Future<UserModel?> getUser(String userId);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(String userId);
}
