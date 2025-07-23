import 'dart:typed_data';

class MediaEntity {
  final String postId;
  final List<Uint8List> files;
  final List<String> fileNames;

  MediaEntity({
    required this.postId,
    required this.files,
    required this.fileNames,
  });
}
