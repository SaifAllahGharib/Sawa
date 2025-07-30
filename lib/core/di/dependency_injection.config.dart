// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:failure_handler/failure_handler.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/data_sources/firebase_auth_remote_data_source.dart'
    as _i992;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/email_verified_usecase.dart'
    as _i104;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/send_email_verification_usercase.dart'
    as _i699;
import '../../features/auth/domain/usecases/signup_usecase.dart' as _i57;
import '../../features/auth/presentation/cubits/auth/auth_cubit.dart' as _i235;
import '../../features/auth/presentation/cubits/login/login_cubit.dart'
    as _i1019;
import '../../features/auth/presentation/cubits/signup/signup_cubit.dart'
    as _i24;
import '../../features/auth/presentation/cubits/verification/verification/verification_cubit.dart'
    as _i739;
import '../../features/home/data/data_sources/firebase_post_remote_data_source.dart'
    as _i49;
import '../../features/home/data/data_sources/home_post_remote_data_source.dart'
    as _i1070;
import '../../features/home/data/data_sources/home_upload_storage_remote_data_source.dart'
    as _i65;
import '../../features/home/data/data_sources/supabase_home_upload_storage_remote_data_source.dart'
    as _i167;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/create_post_usecase.dart' as _i992;
import '../../features/home/domain/usecases/delete_post_usecase.dart' as _i1006;
import '../../features/home/domain/usecases/upload_post_media_to_table_usecase.dart'
    as _i457;
import '../../features/home/domain/usecases/upload_post_media_usecase.dart'
    as _i251;
import '../../features/home/presentation/cubits/home/home_cubit.dart' as _i715;
import '../../features/profile/data/data_source/firebase_profile_remote_data_source.dart'
    as _i74;
import '../../features/profile/data/data_source/profile_remote_data_source.dart'
    as _i998;
import '../../features/profile/data/data_source/profile_upload_storage_remote_data_source.dart'
    as _i184;
import '../../features/profile/data/data_source/supabase_profile_upload_storage_remote_data_source.dart'
    as _i56;
import '../../features/profile/data/repository/profile_repository_impl.dart'
    as _i309;
import '../../features/profile/domain/repository/profile_repository.dart'
    as _i364;
import '../../features/profile/domain/usecases/get_profile_usecase.dart'
    as _i965;
import '../../features/profile/domain/usecases/update_profile_name_usecase.dart'
    as _i643;
import '../../features/profile/domain/usecases/upload_profile_image_usecase.dart'
    as _i813;
import '../../features/profile/presentation/cubit/profile/profile_cubit.dart'
    as _i771;
import '../clients/firebase_client.dart' as _i244;
import '../clients/supabase_clint.dart' as _i207;
import '../helpers/image_picker_helper.dart' as _i753;
import '../helpers/shared_preferences_helper.dart' as _i285;
import '../shared/cubits/locale_cubit.dart' as _i3;
import '../shared/cubits/main/main_cubit.dart' as _i302;
import '../shared/cubits/media/media_cubit.dart' as _i814;
import '../shared/cubits/theme_cubit.dart' as _i128;
import '../user/data/data_source/firebase_user_remote_data_source.dart' as _i10;
import '../user/data/data_source/user_remote_data_source.dart' as _i386;
import '../user/data/repository/user_repository_impl.dart' as _i456;
import '../user/domain/repository/user_repository.dart' as _i329;
import '../user/domain/usecase/create_user_usecase.dart' as _i443;
import '../user/domain/usecase/get_user_use_case.dart' as _i629;
import '../user/domain/usecase/user_exists_usecase.dart' as _i940;
import '../user/presentation/cubit/user/user_cubit.dart' as _i372;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i244.FirebaseClient>(() => _i244.FirebaseClient());
    gh.lazySingleton<_i207.SupabaseClint>(() => _i207.SupabaseClint());
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    gh.lazySingleton<_i183.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i281.ErrorHandler>(() => appModule.errorHandler);
    gh.lazySingleton<_i65.IHomeUploadStorageRemoteDataSource>(
      () => _i167.SupabaseHomeUploadStorageRemoteDataSource(
        gh<_i207.SupabaseClint>(),
      ),
    );
    await gh.lazySingletonAsync<_i285.SharedPreferencesHelper>(
      () => appModule.providePrefsHelper(gh<_i974.Logger>()),
      preResolve: true,
    );
    gh.lazySingleton<_i25.IAuthRemoteDataSource>(
      () => _i992.FirebaseAuthRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i184.IProfileUploadStorageRemoteDataSource>(
      () => _i56.SupabaseProfileUploadStorageRemoteDataSource(
        gh<_i207.SupabaseClint>(),
      ),
    );
    gh.singleton<_i3.LocaleCubit>(
      () => _i3.LocaleCubit(gh<_i285.SharedPreferencesHelper>()),
    );
    gh.singleton<_i128.ThemeCubit>(
      () => _i128.ThemeCubit(gh<_i285.SharedPreferencesHelper>()),
    );
    gh.lazySingleton<_i998.IProfileRemoteDataSource>(
      () => _i74.FirebaseProfileRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i1070.IHomePostRemoteDataSource>(
      () => _i49.FirebasePostRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i386.IUserRemoteDataSource>(
      () => _i10.FirebaseUserRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i753.ImagePickerHelper>(
      () => _i753.ImagePickerHelper(gh<_i183.ImagePicker>()),
    );
    gh.factory<_i814.MediaCubit>(
      () => _i814.MediaCubit(gh<_i753.ImagePickerHelper>()),
    );
    gh.lazySingleton<_i787.IAuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i25.IAuthRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i364.IProfileRepository>(
      () => _i309.ProfileRepositoryImpl(
        gh<_i998.IProfileRemoteDataSource>(),
        gh<_i184.IProfileUploadStorageRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i329.IUserRepository>(
      () => _i456.UserRepositoryImpl(
        gh<_i386.IUserRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i0.IHomeRepository>(
      () => _i76.HomeRepositoryImpl(
        gh<_i65.IHomeUploadStorageRemoteDataSource>(),
        gh<_i1070.IHomePostRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.factory<_i104.EmailVerifiedUseCase>(
      () => _i104.EmailVerifiedUseCase(gh<_i787.IAuthRepository>()),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.IAuthRepository>()),
    );
    gh.factory<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.IAuthRepository>()),
    );
    gh.factory<_i699.SendEmailVerificationUserCase>(
      () => _i699.SendEmailVerificationUserCase(gh<_i787.IAuthRepository>()),
    );
    gh.factory<_i57.SignupUseCase>(
      () => _i57.SignupUseCase(gh<_i787.IAuthRepository>()),
    );
    gh.factory<_i965.GetProfileUseCase>(
      () => _i965.GetProfileUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i643.UpdateProfileNameUseCase>(
      () => _i643.UpdateProfileNameUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i813.UploadProfileImageUseCase>(
      () => _i813.UploadProfileImageUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i629.GetUserUseCase>(
      () => _i629.GetUserUseCase(gh<_i329.IUserRepository>()),
    );
    gh.singleton<_i235.AuthCubit>(
      () =>
          _i235.AuthCubit(gh<_i244.FirebaseClient>(), gh<_i48.LogoutUseCase>()),
    );
    gh.factory<_i992.CreatePostUseCase>(
      () => _i992.CreatePostUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i1006.DeletePostUseCase>(
      () => _i1006.DeletePostUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i457.UploadPostMediaToTableUseCase>(
      () => _i457.UploadPostMediaToTableUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i251.UploadPostMediaUseCase>(
      () => _i251.UploadPostMediaUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i372.UserCubit>(
      () => _i372.UserCubit(gh<_i629.GetUserUseCase>()),
    );
    gh.factory<_i443.CreateUserUseCase>(
      () => _i443.CreateUserUseCase(gh<_i329.IUserRepository>()),
    );
    gh.factory<_i940.UserExistsUseCase>(
      () => _i940.UserExistsUseCase(gh<_i329.IUserRepository>()),
    );
    gh.factory<_i715.HomeCubit>(
      () => _i715.HomeCubit(
        gh<_i251.UploadPostMediaUseCase>(),
        gh<_i992.CreatePostUseCase>(),
        gh<_i457.UploadPostMediaToTableUseCase>(),
        gh<_i1006.DeletePostUseCase>(),
        gh<_i244.FirebaseClient>(),
      ),
    );
    gh.factory<_i771.ProfileCubit>(
      () => _i771.ProfileCubit(
        gh<_i643.UpdateProfileNameUseCase>(),
        gh<_i965.GetProfileUseCase>(),
        gh<_i813.UploadProfileImageUseCase>(),
      ),
    );
    gh.factory<_i1019.LoginCubit>(
      () => _i1019.LoginCubit(gh<_i188.LoginUseCase>()),
    );
    gh.factory<_i24.SignupCubit>(
      () => _i24.SignupCubit(
        gh<_i57.SignupUseCase>(),
        gh<_i443.CreateUserUseCase>(),
      ),
    );
    gh.factory<_i739.VerificationCubit>(
      () => _i739.VerificationCubit(
        gh<_i104.EmailVerifiedUseCase>(),
        gh<_i699.SendEmailVerificationUserCase>(),
      ),
    );
    gh.singleton<_i302.MainCubit>(
      () => _i302.MainCubit(
        gh<_i128.ThemeCubit>(),
        gh<_i3.LocaleCubit>(),
        gh<_i235.AuthCubit>(),
        gh<_i372.UserCubit>(),
        gh<_i244.FirebaseClient>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
