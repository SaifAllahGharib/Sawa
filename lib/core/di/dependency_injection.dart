import 'package:get_it/get_it.dart';
import 'package:intern_intelligence_social_media_application/core/network/firebase_clint.dart';
import 'package:intern_intelligence_social_media_application/core/network/supabase_clint.dart';
import 'package:logger/logger.dart';

import '../../features/auth/data/api/auth_api.dart';
import '../../features/auth/data/api/firebase_auth_impl.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/data/services/auth_service_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/cubits/signup/signup_cubit.dart';
import '../helpers/shared_preferences_helper.dart';
import '../network/dio_client.dart';
import '../network/firebase_auth_api.dart';
import '../shared/cubits/locale_cubit.dart';
import '../shared/cubits/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Helper and Clint
  getIt.registerLazySingleton(() => SharedPreferencesHelper(Logger()));
  getIt.registerLazySingleton(() => DioClint.create());
  getIt.registerLazySingleton(() => SupabaseClint());
  getIt.registerLazySingleton(() => FirebaseClint());

  // APIs
  getIt.registerLazySingleton<FirebaseAuthApi>(() => FirebaseAuthApi(getIt()));
  getIt.registerLazySingleton<AuthApi>(() => FirebaseAuthApiImpl(getIt()));

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthServiceImpl(getIt()));

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // UseCass
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt()));
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
}
