import '../models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  Future<void> uploadProfileImage(String path);

  Future<void> updateProfileName(String newName);

  Future<ProfileModel> getProfile();
}
