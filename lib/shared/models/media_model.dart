import 'dart:io';
import 'dart:typed_data';

import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:path/path.dart' as p;

class MediaModel {
  final String id;
  final List<Uint8List> files;
  final List<String> fileNames;

  MediaModel({required this.id, required this.files, required this.fileNames});

  static Future<MediaModel> fromEntity(MediaEntity postMedia) async {
    final files = <Uint8List>[];
    final fileNames = <String>[];

    for (final media in postMedia.media) {
      final file = File(media.path);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        final name = p.basename(media.path);
        files.add(bytes);
        fileNames.add(name);
      }
    }

    return MediaModel(id: postMedia.id, files: files, fileNames: fileNames);
  }
}
