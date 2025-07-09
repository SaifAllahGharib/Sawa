import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/supabase_service.dart';

class SupabaseAuthService extends AuthService {
  final SupabaseService _supabaseService;

  SupabaseAuthService(this._supabaseService);

  @override
  Future<AuthResponse> createAccount(SignupModel model) async {
    return await _supabaseService.auth.signUp(
      email: model.email,
      password: model.password,
    );
  }

  @override
  Future<AuthResponse> login(LoginModel model) async {
    return await _supabaseService.auth.signInWithPassword(
      email: model.email,
      password: model.password,
    );
  }
}
