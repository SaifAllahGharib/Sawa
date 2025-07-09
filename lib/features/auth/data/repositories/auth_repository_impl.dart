import 'package:failure_handler/failure_handler.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Result<AppFailure, User?>> createAccount(SignupEntity entity) async {
    try {
      final response = await _authRemoteDataSource.createAccount(
        SignupModel(
          name: entity.name,
          email: entity.email,
          password: entity.password,
        ),
      );

      return Success(response.user);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, User?>> login(LoginEntity entity) async {
    try {
      final response = await _authRemoteDataSource.login(
        LoginModel(email: entity.email, password: entity.password),
      );

      return Success(response.user);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
