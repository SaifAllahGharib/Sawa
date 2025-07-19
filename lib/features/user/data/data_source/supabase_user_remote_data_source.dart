import 'package:intern_intelligence_social_media_application/core/clients/supabase_clint.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/data_source/user_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';

class SupabaseUserRemoteDataSource implements IUserRemoteDataSource {
  final SupabaseClint _supabaseClint;

  SupabaseUserRemoteDataSource(this._supabaseClint);

  @override
  Future<bool> createUser(UserModel user) async {
    try {
      await _supabaseClint.db.from('users').insert(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final response = await _supabaseClint.db
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle();

    return UserModel.fromJson(response ?? {});
  }

  @override
  Future<bool> userExists(String userId) async {
    try {
      final response = await _supabaseClint.db
          .from('users')
          .select('id')
          .eq('id', userId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      await _supabaseClint.db
          .from('users')
          .update(user.toJson())
          .eq('id', user.id);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteUser(String userId) async {
    try {
      await _supabaseClint.db.from('users').delete().eq('id', userId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
