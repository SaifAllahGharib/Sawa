import '../models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  Future<void> uploadProfileImage(String path);

  Future<void> updateProfileName(String newName);

  Future<void> updateProfileBio(String newBio);

  Future<ProfileModel> getProfile(String uId);

  Future<void> deletePost(String postId);
}
