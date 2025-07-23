import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/main/main_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/email_verified_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/login_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/logout_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/domain/usecases/send_email_verification_usercase.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/home_post_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/supabase_home_upload_storage_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/data_sources/supabase_post_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/home/data/repositories/home_repository_impl.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/repositories/home_repository.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/create_post_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/delete_post_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/upload_post_media_to_table_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/upload_post_media_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/data_source/supabase_user_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/data_source/user_remote_data_source.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/repository/user_repository_impl.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/repository/user_repository.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/usecase/get_user_use_case.dart';
import 'package:intern_intelligence_social_media_application/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:logger/logger.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/data_sources/firebase_auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/cubits/signup/signup_cubit.dart';
import '../../features/auth/presentation/cubits/verification/verification/verification_cubit.dart';
import '../../features/home/data/data_sources/home_upload_storage_remote_data_source.dart';
import '../clients/dio_client.dart';
import '../clients/supabase_clint.dart';
import '../helpers/image_picker_helper.dart';
import '../helpers/shared_preferences_helper.dart';
import '../shared/cubits/locale_cubit.dart';
import '../shared/cubits/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Helper and Clint
  getIt.registerLazySingleton(() => SharedPreferencesHelper(Logger()));
  getIt.registerLazySingleton(() => ImagePickerHelper(ImagePicker()));
  getIt.registerLazySingleton(() => DioClint.create());
  getIt.registerLazySingleton(() => FirebaseClient());
  getIt.registerLazySingleton(() => SupabaseClint());

  // Data Sources
  getIt.registerLazySingleton<IAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<IUserRemoteDataSource>(
    () => SupabaseUserRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<IHomeUploadStorageRemoteDataSource>(
    () => SupabaseHomeUploadStorageRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<IHomePostRemoteDataSource>(
    () => SupabaseHomePostRemoteDataSource(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IHomeRepository>(
    () => HomeRepositoryImpl(getIt(), getIt()),
  );

  // UseCass
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SendEmailVerificationUserCase(getIt()));
  getIt.registerLazySingleton(() => EmailVerifiedUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadPostMediaUseCase(getIt()));
  getIt.registerLazySingleton(() => CreatePostUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadPostMediaToTableUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton(() => LocaleCubit(getIt()));
  getIt.registerLazySingleton(() => ThemeCubit(getIt()));
  getIt.registerLazySingleton(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory(() => SignupCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => VerificationCubit(getIt(), getIt()));
  getIt.registerLazySingleton(() => UserCubit(getIt()));
  getIt.registerFactory(() => HomeCubit(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(() => MediaCubit(getIt()));
  getIt.registerLazySingleton(
    () => MainCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
}
