abstract class IProfileLocalDataSource {
  Future<void> uploadProfileImage(String path);

  Future<void> updateProfileName(String newName);

  Future<void> updateProfileBio(String newBio);
}
