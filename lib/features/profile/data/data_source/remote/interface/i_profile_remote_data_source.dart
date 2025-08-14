import '../../../models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  Future<void> uploadProfileImage({required String path});

  Future<void> updateProfileName({required String newName});

  Future<void> updateProfileBio({required String newBio});

  Future<ProfileModel> getProfile({required String uId});

  Future<void> deletePost({required String postId});
}
