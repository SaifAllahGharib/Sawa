import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/result.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/login_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/models/signup_model.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/login_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/entities/signup_entity.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/repository/user_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRepository _userRepository;

  AuthRepositoryImpl(this._authRemoteDataSource, this._userRepository);

  @override
  Future<Result<AppFailure, bool>> createAccount(SignupEntity entity) async {
    try {
      final response = await _authRemoteDataSource.createAccount(
        SignupModel(
          name: entity.name,
          email: entity.email,
          password: entity.password,
        ),
      );

      if (response != null) {
        final createdUser = await _userRepository.createUser(
          UserEntity(id: response, name: entity.name, email: entity.email),
        );

        return createdUser;
      }

      await _authRemoteDataSource.deleteUser(
        LoginModel(email: entity.email, password: entity.password),
      );

      return const Failure(ServerFailure('failed_to_store_user_in_db'));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<AppFailure, void>> login(LoginEntity entity) async {
    try {
      final response = await _authRemoteDataSource.login(
        LoginModel(email: entity.email, password: entity.password),
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
