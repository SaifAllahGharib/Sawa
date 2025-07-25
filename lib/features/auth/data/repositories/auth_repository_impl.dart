import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Result<AppFailure, String?>> createAccount(SignupEntity entity) async {
    try {
      final response = await _authRemoteDataSource.createAccount(
        SignupModel.fromEntity(entity),
      );

      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, String?>> login(LoginEntity entity) async {
    try {
      final response = await _authRemoteDataSource.login(
        LoginModel.fromEntity(entity),
      );
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, bool>> emailVerified() async {
    try {
      return Success(await _authRemoteDataSource.emailVerified());
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> sendEmailVerification() async {
    try {
      return Success(await _authRemoteDataSource.sendEmailVerification());
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> logout() async {
    try {
      return Success(await _authRemoteDataSource.logout());
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
