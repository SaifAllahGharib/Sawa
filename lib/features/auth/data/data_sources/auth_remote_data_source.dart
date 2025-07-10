import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

import '../services/auth_service.dart';

sealed class AuthRemoteDataSource {
  Future<void> login(LoginModel model);

  Future<void> createAccount(SignupModel model);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService _authService;

  AuthRemoteDataSourceImpl(this._authService);

  @override
  Future<void> createAccount(SignupModel model) async {
    return await _authService.createAccount(model);
  }

  @override
  Future<void> login(LoginModel model) async {
    return await _authService.login(model);
  }
}
