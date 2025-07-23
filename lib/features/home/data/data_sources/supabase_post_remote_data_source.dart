import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/home_post_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/create_post_model.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/models/post_media_model.dart';

import '../../../../core/clients/supabase_clint.dart';

class SupabaseHomePostRemoteDataSource implements IHomePostRemoteDataSource {
  final SupabaseClint _supabaseClint;

  SupabaseHomePostRemoteDataSource(this._supabaseClint);

  @override
  Future<String?> createPost(CreatePostModel postModel) async {
    final response = await _supabaseClint.db
        .from('posts')
        .insert(postModel.toJson())
        .select()
        .maybeSingle();

    if (response == null) return null;

    return response['id'] as String;
  }

  @override
  Future<bool> uploadPostMedia(List<PostMediaModel> mediaModels) async {
    final mediaJson = mediaModels.map((media) => media.toJson()).toList();

    return _supabaseClint.db
        .from('post_media')
        .insert(mediaJson)
        .select()
        .then((_) => true)
        .catchError((_) => false);
  }

  @override
  Future<bool> deletePost(String postId) async {
    return await _supabaseClint.db
        .from('posts')
        .delete()
        .match({'id': postId})
        .then((value) async {
          final storage = _supabaseClint.db.storage.from('media');

          final files = await storage.list(path: 'post_media/$postId');

          final filePaths = files
              .map((file) => 'post_media/$postId/${file.name}')
              .toList();

          if (filePaths.isNotEmpty) {
            await storage.remove(filePaths);
          }

          return true;
        })
        .catchError((_) => false);
  }
}
