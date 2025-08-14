import 'package:failure_handler/failure_handler.dart';
import 'package:sawa/features/auth/data/models/login_model.dart';
import 'package:sawa/features/auth/data/models/signup_model.dart';

abstract class IAuthRepository {
  FutureResult<String?> login({required LoginModel loginModel});

  FutureResult<String?> createAccount({required SignupModel signupModel});

  FutureResult<bool> emailVerified();

  FutureResult<void> sendEmailVerification();

  FutureResult<void> logout();
}
