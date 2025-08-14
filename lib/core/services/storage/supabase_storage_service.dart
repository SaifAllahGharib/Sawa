import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../clients/supabase_clint.dart';
import 'i_storage_service.dart';

@LazySingleton(as: IStorageService)
class SupabaseStorageService implements IStorageService {
  final SupabaseClint _supabaseClient;

  SupabaseStorageService(this._supabaseClient);

  @override
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required Uint8List file,
    String? contentType,
    bool overwrite = false,
  }) async {
    final type =
        contentType ?? lookupMimeType(path) ?? 'application/octet-stream';

    try {
      await _supabaseClient.db.storage
          .from(bucket)
          .uploadBinary(
            path,
            file,
            fileOptions: FileOptions(contentType: type, upsert: overwrite),
          );
    } on StorageException catch (e) {
      if (e.message.contains('The resource already exists') && !overwrite) {
        return getPublicUrl(bucket: bucket, path: path);
      }
      rethrow;
    }

    return getPublicUrl(bucket: bucket, path: path);
  }

  @override
  Future<List<String>> uploadFiles({
    required String bucket,
    required String basePath,
    required List<Uint8List> files,
    required List<String> fileNames,
    List<String?>? contentTypes,
    bool overwrite = false,
  }) async {
    final results = await Future.wait(
      files.asMap().entries.map((entry) {
        final i = entry.key;
        final file = entry.value;
        final fileName = fileNames[i];
        final path = '$basePath/$fileName';
        final type =
            contentTypes?[i] ??
            lookupMimeType(fileName) ??
            'application/octet-stream';

        return _uploadSingleFile(
          bucket: bucket,
          path: path,
          file: file,
          contentType: type,
          overwrite: overwrite,
        );
      }),
    );

    return results;
  }

  Future<String> _uploadSingleFile({
    required String bucket,
    required String path,
    required Uint8List file,
    required String contentType,
    required bool overwrite,
  }) async {
    try {
      await _supabaseClient.db.storage
          .from(bucket)
          .uploadBinary(
            path,
            file,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: overwrite,
            ),
          );
    } on StorageException catch (e) {
      if (e.message.contains('The resource already exists') && !overwrite) {
        return getPublicUrl(bucket: bucket, path: path);
      }
      rethrow;
    }

    return getPublicUrl(bucket: bucket, path: path);
  }

  @override
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    await _supabaseClient.db.storage.from(bucket).remove([path]);
  }

  @override
  String getPublicUrl({required String bucket, required String path}) {
    return _supabaseClient.db.storage.from(bucket).getPublicUrl(path);
  }
}
