import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabaseService {
  final _supabase = Supabase.instance.client;

  SupabaseService._();

  static final SupabaseService _instance = SupabaseService._();

  factory SupabaseService() {
    return _instance;
  }

  GoTrueClient get auth => _instance._supabase.auth;
  SupabaseClient get db => _instance._supabase;
}
