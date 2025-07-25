import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';

abstract class IAuthRepository {
  Future<Result<AppFailure, String?>> login(LoginEntity entity);

  Future<Result<AppFailure, String?>> createAccount(SignupEntity entity);

  Future<Result<AppFailure, bool>> emailVerified();

  Future<Result<AppFailure, void>> sendEmailVerification();

  Future<Result<AppFailure, void>> logout();
}
