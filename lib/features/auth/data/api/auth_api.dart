import '../models/login_model.dart';
import '../models/signup_model.dart';

abstract class AuthApi {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);

  Future<bool> emailVerified();

  Future<void> sendEmailVerification();

  Future<void> deleteUser(LoginModel model);
}
