import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(this._authRemoteDataSource, this._errorHandler);

  @override
  Future<Result<AppFailure, String?>> createAccount(SignupEntity entity) async {
    return _errorHandler.handleFutureWithTryCatch<String?>(
      () async => await _authRemoteDataSource.createAccount(
        SignupModel.fromEntity(entity),
      ),
    );
  }

  @override
  Future<Result<AppFailure, String?>> login(LoginEntity entity) async {
    return _errorHandler.handleFutureWithTryCatch<String?>(
      () async =>
          await _authRemoteDataSource.login(LoginModel.fromEntity(entity)),
    );
  }

  @override
  Future<Result<AppFailure, bool>> emailVerified() async {
    return _errorHandler.handleFutureWithTryCatch<bool>(
      () async => await _authRemoteDataSource.emailVerified(),
    );
  }

  @override
  Future<Result<AppFailure, void>> sendEmailVerification() async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _authRemoteDataSource.sendEmailVerification(),
    );
  }

  @override
  Future<Result<AppFailure, void>> logout() async {
    return _errorHandler.handleFutureWithTryCatch<void>(
      () async => await _authRemoteDataSource.logout(),
    );
  }
}
