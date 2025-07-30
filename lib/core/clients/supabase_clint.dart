import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class SupabaseClint {
  final SupabaseClient _client = Supabase.instance.client;

  GoTrueClient get auth => _client.auth;

  SupabaseClient get db => _client;
}
