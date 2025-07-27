import '../../../../core/shared/models/media_model.dart';

abstract class IProfileUploadStorageRemoteDataSource {
  Future<String> uploadProfileImage(MediaModel mediaModel);
}
