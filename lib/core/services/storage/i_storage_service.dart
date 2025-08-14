import 'dart:typed_data';

abstract class IStorageService {
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required Uint8List file,
    String? contentType,
    bool overwrite = false,
  });

  Future<List<String>> uploadFiles({
    required String bucket,
    required String basePath,
    required List<Uint8List> files,
    required List<String> fileNames,
    List<String?>? contentTypes,
    bool overwrite = false,
  });

  Future<void> deleteFile({required String bucket, required String path});

  String getPublicUrl({required String bucket, required String path});
}
