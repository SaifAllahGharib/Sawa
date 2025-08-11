import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/clients/supabase_clint.dart';
import '../../../../shared/data/models/media_model.dart';
import 'profile_upload_storage_remote_data_source.dart';

@LazySingleton(as: IProfileUploadStorageRemoteDataSource)
class SupabaseProfileUploadStorageRemoteDataSource
    implements IProfileUploadStorageRemoteDataSource {
  final SupabaseClint _supabaseClint;

  SupabaseProfileUploadStorageRemoteDataSource(this._supabaseClint);

  @override
  Future<String> uploadProfileImage(MediaModel mediaModel) async {
    final file = mediaModel.files[0];
    final fileName = mediaModel.fileNames[0];
    final path = 'profile_media/${mediaModel.id}/$fileName';
    final contentType = lookupMimeType(fileName) ?? 'application/octet-stream';

    try {
      await _supabaseClint.db.storage
          .from('media')
          .uploadBinary(
            path,
            file,
            fileOptions: FileOptions(contentType: contentType),
          );
    } on StorageException catch (e) {
      if (e.message.contains('The resource already exists')) {
        return _supabaseClint.db.storage.from('media').getPublicUrl(path);
      }
      rethrow;
    }

    return _supabaseClint.db.storage.from('media').getPublicUrl(path);
  }
}
