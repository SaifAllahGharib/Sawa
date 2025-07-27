import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/clients/supabase_clint.dart';
import '../../../../core/shared/models/media_model.dart';
import 'profile_upload_storage_remote_data_source.dart';

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
    final String image = await _supabaseClint.db.storage
        .from('media')
        .uploadBinary(
          path,
          file,
          fileOptions: FileOptions(contentType: contentType),
        )
        .then(
          (_) => _supabaseClint.db.storage.from('media').getPublicUrl(path),
        );

    return image;
  }
}
