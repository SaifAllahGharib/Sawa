import '../../../../core/shared/models/media_item.dart';

class MediaEntity {
  final String postId;
  final List<MediaItem> media;

  MediaEntity({required this.postId, required this.media});
}
