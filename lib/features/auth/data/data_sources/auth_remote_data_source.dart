import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

sealed class AuthRemoteDataSource {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthApi _authApi;

  AuthRemoteDataSourceImpl(this._authApi);

  @override
  Future<void> createAccount(SignupModel model) async {
    return await _authApi.createAccount(model);
  }

  @override
  Future<void> login(LoginModel model) async {
    return await _authApi.login(model);
  }
}
