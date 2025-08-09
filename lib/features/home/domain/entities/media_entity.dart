import '../../../../shared/models/media_item.dart';

class MediaEntity {
  final String id;
  final List<MediaItem> media;

  MediaEntity({required this.id, required this.media});
}
