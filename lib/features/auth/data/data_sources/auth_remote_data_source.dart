import 'package:sawa/features/auth/data/models/login_model.dart';
import 'package:sawa/features/auth/data/models/signup_model.dart';

abstract class IAuthRemoteDataSource {
  Future<String?> login({required LoginModel loginModel});

  Future<String?> createAccount({required SignupModel signupModel});

  Future<bool> emailVerified();

  Future<void> sendEmailVerification();

  Future<void> deleteUser({required LoginModel loginModel});

  Future<void> logout();
}
