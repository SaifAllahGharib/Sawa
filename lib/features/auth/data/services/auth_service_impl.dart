import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

import 'auth_service.dart';

class AuthServiceImpl extends AuthService {
  final AuthApi _authApi;

  AuthServiceImpl(this._authApi);

  @override
  Future<void> createAccount(SignupModel model) async {
    return await _authApi.createAccount(model);
  }

  @override
  Future<void> login(LoginModel model) async {
    return await _authApi.login(model);
  }
}
