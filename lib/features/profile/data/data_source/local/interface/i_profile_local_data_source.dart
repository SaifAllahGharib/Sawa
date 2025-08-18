abstract class IProfileLocalDataSource {
  Future<void> updateProfileImage({required String path});

  Future<void> updateProfileName({required String newName});

  Future<void> updateProfileBio({required String newBio});
}
