import '../models/login_model.dart';
import '../models/signup_model.dart';

abstract class AuthApi {
  Future<dynamic> login(LoginModel model);

  Future<dynamic> createAccount(SignupModel model);
}
