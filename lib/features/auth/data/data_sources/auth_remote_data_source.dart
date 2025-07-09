import 'package:intern_intelligence_social_media_application/core/services/auth_service.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginModel model);

  Future<AuthResponse> createAccount(SignupModel model);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService _authService;

  AuthRemoteDataSourceImpl(this._authService);

  @override
  Future<AuthResponse> createAccount(SignupModel model) async {
    return await _authService.createAccount(model);
  }

  @override
  Future<AuthResponse> login(LoginModel model) async {
    return await _authService.login(model);
  }
}
