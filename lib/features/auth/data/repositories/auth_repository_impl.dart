import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(this._authRemoteDataSource, this._errorHandler);

  @override
  FutureResult<String?> createAccount(SignupEntity entity) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _authRemoteDataSource.createAccount(
        SignupModel.fromEntity(entity),
      ),
    );
  }

  @override
  FutureResult<String?> login(LoginEntity entity) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _authRemoteDataSource.login(LoginModel.fromEntity(entity)),
    );
  }

  @override
  FutureResult<bool> emailVerified() async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _authRemoteDataSource.emailVerified(),
    );
  }

  @override
  FutureResult<void> sendEmailVerification() async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _authRemoteDataSource.sendEmailVerification(),
    );
  }

  @override
  FutureResult<void> logout() async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _authRemoteDataSource.logout(),
    );
  }
}
