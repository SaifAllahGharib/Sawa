import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';

abstract class AuthService {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);
}
