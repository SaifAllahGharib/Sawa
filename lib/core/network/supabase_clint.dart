import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabaseClint {
  final _supabase = Supabase.instance.client;

  SupabaseClint._();

  static final SupabaseClint _instance = SupabaseClint._();

  factory SupabaseClint() {
    return _instance;
  }

  GoTrueClient get auth => _instance._supabase.auth;

  SupabaseClient get db => _instance._supabase;
}
