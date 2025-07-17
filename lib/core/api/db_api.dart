import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';

abstract class DbApi {
  Future<dynamic> createUser(UserModel user);

  Future<UserModel?> getUser(String uId);

  Future<bool> userExists(String uId);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(String uId);
}
