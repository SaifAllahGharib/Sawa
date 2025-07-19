import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

abstract class IAuthRemoteDataSource {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);

  Future<bool> emailVerified();

  Future<void> sendEmailVerification();

  Future<void> deleteUser(LoginModel model);

  Future<void> logout();
}
