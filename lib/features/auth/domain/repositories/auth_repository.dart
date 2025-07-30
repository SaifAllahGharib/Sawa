import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';

abstract class IAuthRepository {
  FutureResult<String?> login(LoginEntity entity);

  FutureResult<String?> createAccount(SignupEntity entity);

  FutureResult<bool> emailVerified();

  FutureResult<void> sendEmailVerification();

  FutureResult<void> logout();
}
