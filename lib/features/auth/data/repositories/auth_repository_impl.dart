import 'package:failure_handler/failure_handler.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(this._authRemoteDataSource, this._errorHandler);

  @override
  FutureResult<String?> createAccount({
    required SignupModel signupModel,
  }) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async =>
          await _authRemoteDataSource.createAccount(signupModel: signupModel),
    );
  }

  @override
  FutureResult<String?> login({required LoginModel loginModel}) async {
    return _errorHandler.handleFutureWithTryCatch(
      () async => await _authRemoteDataSource.login(loginModel: loginModel),
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
