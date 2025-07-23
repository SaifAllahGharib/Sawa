import 'dart:typed_data';

import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';

class MediaModel {
  final String postId;
  final List<Uint8List> files;
  final List<String> fileNames;

  MediaModel({
    required this.postId,
    required this.files,
    required this.fileNames,
  });

  factory MediaModel.fromEntity(MediaEntity postMedia) {
    return MediaModel(
      postId: postMedia.postId,
      files: postMedia.files,
      fileNames: postMedia.fileNames,
    );
  }

  MediaEntity toEntity() {
    return MediaEntity(postId: postId, files: files, fileNames: fileNames);
  }
}
