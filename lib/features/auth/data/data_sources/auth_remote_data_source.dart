import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

sealed class AuthRemoteDataSource {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);

  Future<bool> emailVerified();

  Future<void> sendEmailVerification();

  Future<void> deleteUser(LoginModel model);

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi _authApi;

  AuthRemoteDataSourceImpl(this._authApi);

  @override
  Future<String?> createAccount(SignupModel model) async {
    return await _authApi.createAccount(model);
  }

  @override
  Future<void> login(LoginModel model) async {
    return await _authApi.login(model);
  }

  @override
  Future<bool> emailVerified() async {
    return await _authApi.emailVerified();
  }

  @override
  Future<void> sendEmailVerification() async {
    return await _authApi.sendEmailVerification();
  }

  @override
  Future<void> deleteUser(LoginModel model) async {
    return await _authApi.deleteUser(model);
  }

  @override
  Future<void> logout() async {
    return await _authApi.logout();
  }
}
