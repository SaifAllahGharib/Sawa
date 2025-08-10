import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';

abstract class IUserLocalDataSource {
  UserModel? getUser();

  Future<void> saveUser(UserModel user);
}
