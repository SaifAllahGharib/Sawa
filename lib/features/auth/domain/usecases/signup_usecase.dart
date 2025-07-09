import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/core/usecases/usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class SignupUseCase extends UseCase<Result<AppFailure, User?>, SignupEntity> {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  @override
  Future<Result<AppFailure, User?>> call(SignupEntity params) async {
    return await _authRepository.createAccount(params);
  }
}
