import '../../../../shared/data/models/media_model.dart';

abstract class IHomeUploadStorageRemoteDataSource {
  Future<List<String>> uploadPostMedia(MediaModel mediaModel);
}
