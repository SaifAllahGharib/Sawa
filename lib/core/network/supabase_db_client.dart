import 'package:intern_intelligence_social_media_application/core/api/db_api.dart';
import 'package:intern_intelligence_social_media_application/core/clients/supabase_clint.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/user_model.dart';

class SupabaseDbClient extends DbApi {
  final SupabaseClint _supabaseClint;

  SupabaseDbClient(this._supabaseClint);

  @override
  Future<void> setUser(UserModel user) async {
    await _supabaseClint.db.from('users').insert(user.toJson());
  }

  @override
  Future<UserModel?> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
