import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_model.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/clients/supabase_clint.dart';
import 'home_upload_storage_remote_data_source.dart';

@LazySingleton(as: IHomeUploadStorageRemoteDataSource)
class SupabaseHomeUploadStorageRemoteDataSource
    implements IHomeUploadStorageRemoteDataSource {
  final SupabaseClint _supabaseClint;

  SupabaseHomeUploadStorageRemoteDataSource(this._supabaseClint);

  @override
  Future<List<String>> uploadPostMedia(MediaModel mediaModel) async {
    final uploadFutures = <Future<String>>[];

    for (int i = 0; i < mediaModel.files.length; i++) {
      final file = mediaModel.files[i];
      final fileName = mediaModel.fileNames[i];
      final path = 'post_media/${mediaModel.id}/$fileName';
      final contentType =
          lookupMimeType(fileName) ?? 'application/octet-stream';

      uploadFutures.add(
        _supabaseClint.db.storage
            .from('media')
            .uploadBinary(
              path,
              file,
              fileOptions: FileOptions(contentType: contentType),
            )
            .then(
              (_) => _supabaseClint.db.storage.from('media').getPublicUrl(path),
            ),
      );
    }

    return await Future.wait(uploadFutures);
  }
}
