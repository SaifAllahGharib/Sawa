import 'package:get_it/get_it.dart';
import 'package:intern_intelligence_social_media_application/core/api/db_api.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/network/supabase_db_client.dart';
import 'package:intern_intelligence_social_media_application/features/auth/data/api/auth_api.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/email_verified_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/login_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/logout_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/send_email_verification_usercase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/repositories/home_repository_impl.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/data_source/user_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/repository/user_repository_impl.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/repository/user_repository.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/usecase/get_user_use_case.dart';
import 'package:logger/logger.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/cubits/signup/signup_cubit.dart';
import '../../features/auth/presentation/cubits/verification/verification/verification_cubit.dart';
import '../clients/dio_client.dart';
import '../clients/supabase_clint.dart';
import '../helpers/shared_preferences_helper.dart';
import '../network/firebase_auth_client.dart';
import '../shared/cubits/locale_cubit.dart';
import '../shared/cubits/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Helper and Clint
  getIt.registerLazySingleton(() => SharedPreferencesHelper(Logger()));
  getIt.registerLazySingleton(() => DioClint.create());
  getIt.registerLazySingleton(() => SupabaseClint());
  getIt.registerLazySingleton(() => FirebaseClient());

  // APIs
  getIt.registerLazySingleton<AuthApi>(() => FirebaseAuthClient(getIt()));
  getIt.registerLazySingleton<DbApi>(() => SupabaseDbClient(getIt()));

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt()),
  );

  // UseCass
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SendEmailVerificationUserCase(getIt()));
  getIt.registerLazySingleton(() => EmailVerifiedUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt()));
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<VerificationCubit>(
    () => VerificationCubit(getIt(), getIt()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
