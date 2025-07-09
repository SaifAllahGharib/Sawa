import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Result<AppFailure, User?>> login(LoginEntity entity);

  Future<Result<AppFailure, User?>> createAccount(SignupEntity entity);
}
