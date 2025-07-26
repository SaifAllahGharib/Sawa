import '../models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  Future<void> updateProfileImage(String url);

  Future<void> updateProfileName(String newName);

  Future<ProfileModel> getProfile();
}
