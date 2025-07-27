import '../../../../core/shared/models/media_model.dart';

abstract class IHomeUploadStorageRemoteDataSource {
  Future<List<String>> uploadPostMedia(MediaModel mediaModel);
}
