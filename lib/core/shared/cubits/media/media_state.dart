import '../../models/media_item.dart';

class MediaState {
  final List<MediaItem> pickedAssets;

  MediaState({required this.pickedAssets});

  factory MediaState.initial() => MediaState(pickedAssets: []);

  MediaState copyWith({List<MediaItem>? pickedAssets}) {
    return MediaState(pickedAssets: pickedAssets ?? this.pickedAssets);
  }
}
