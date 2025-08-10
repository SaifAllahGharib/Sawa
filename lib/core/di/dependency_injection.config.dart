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
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_database/firebase_database.dart' as _i345;
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
import '../../features/home/domain/usecases/add_reaction_use_case.dart'
    as _i444;
import '../../features/home/domain/usecases/create_post_usecase.dart' as _i992;
import '../../features/home/domain/usecases/delete_post_usecase.dart' as _i1006;
import '../../features/home/domain/usecases/get_default_posts_usecase.dart'
    as _i994;
import '../../features/home/domain/usecases/get_reaction_use_case.dart'
    as _i724;
import '../../features/home/domain/usecases/get_user_reaction_use_case.dart'
    as _i761;
import '../../features/home/domain/usecases/remove_reaction_use_case.dart'
    as _i948;
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
import '../../features/profile/domain/usecases/profile_delete_post_usecase.dart'
    as _i727;
import '../../features/profile/domain/usecases/update_profile_bio_usecase.dart'
    as _i182;
import '../../features/profile/domain/usecases/update_profile_name_usecase.dart'
    as _i643;
import '../../features/profile/domain/usecases/upload_profile_image_usecase.dart'
    as _i813;
import '../../features/profile/presentation/cubit/profile/profile_cubit.dart'
    as _i771;
import '../../features/user/data/data_source/firebase_user_remote_data_source.dart'
    as _i300;
import '../../features/user/data/data_source/user_remote_data_source.dart'
    as _i677;
import '../../features/user/data/repository/user_repository_impl.dart' as _i733;
import '../../features/user/domain/repository/user_repository.dart' as _i450;
import '../../features/user/domain/usecase/create_user_usecase.dart' as _i892;
import '../../features/user/domain/usecase/get_user_use_case.dart' as _i91;
import '../../features/user/domain/usecase/user_exists_usecase.dart' as _i214;
import '../../features/user/presentation/cubit/user/user_cubit.dart' as _i430;
import '../../shared/cubits/locale_cubit.dart' as _i223;
import '../../shared/cubits/main/main_cubit.dart' as _i997;
import '../../shared/cubits/media/media_cubit.dart' as _i556;
import '../../shared/cubits/theme_cubit.dart' as _i253;
import '../../shared/cubits/video_player/video_player_cubit.dart' as _i52;
import '../clients/firebase_client.dart' as _i244;
import '../clients/supabase_clint.dart' as _i207;
import '../helpers/image_picker_helper.dart' as _i753;
import '../helpers/shared_preferences_helper.dart' as _i285;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i52.VideoPlayerCubit>(() => _i52.VideoPlayerCubit());
    gh.singleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.singleton<_i345.FirebaseDatabase>(() => appModule.firebaseDatabase);
    gh.lazySingleton<_i207.SupabaseClint>(() => _i207.SupabaseClint());
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    gh.lazySingleton<_i183.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i281.DioErrorMapper>(() => appModule.dioErrorMapper);
    gh.lazySingleton<_i281.FirebaseErrorMapper>(
      () => appModule.firebaseErrorMapper,
    );
    gh.lazySingleton<_i281.SupabaseErrorMapper>(
      () => appModule.supabaseErrorMapper,
    );
    gh.lazySingleton<_i281.DefaultErrorMapper>(
      () => appModule.defaultErrorMapper,
    );
    gh.lazySingleton<_i281.ErrorLogger>(() => appModule.errorLogger);
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
    gh.singleton<_i244.FirebaseClient>(
      () => _i244.FirebaseClient(
        gh<_i59.FirebaseAuth>(),
        gh<_i345.FirebaseDatabase>(),
      ),
    );
    gh.lazySingleton<_i184.IProfileUploadStorageRemoteDataSource>(
      () => _i56.SupabaseProfileUploadStorageRemoteDataSource(
        gh<_i207.SupabaseClint>(),
      ),
    );
    gh.singleton<_i223.LocaleCubit>(
      () => _i223.LocaleCubit(gh<_i285.SharedPreferencesHelper>()),
    );
    gh.singleton<_i253.ThemeCubit>(
      () => _i253.ThemeCubit(gh<_i285.SharedPreferencesHelper>()),
    );
    gh.lazySingleton<_i677.IUserRemoteDataSource>(
      () => _i300.FirebaseUserRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i998.IProfileRemoteDataSource>(
      () => _i74.FirebaseProfileRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i1070.IHomePostRemoteDataSource>(
      () => _i49.FirebasePostRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.lazySingleton<_i753.ImagePickerHelper>(
      () => _i753.ImagePickerHelper(gh<_i183.ImagePicker>()),
    );
    gh.factory<_i556.MediaCubit>(
      () => _i556.MediaCubit(gh<_i753.ImagePickerHelper>()),
    );
    gh.lazySingleton<_i450.IUserRepository>(
      () => _i733.UserRepositoryImpl(
        gh<_i677.IUserRemoteDataSource>(),
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
    gh.lazySingleton<_i25.IAuthRemoteDataSource>(
      () => _i992.FirebaseAuthRemoteDataSource(gh<_i244.FirebaseClient>()),
    );
    gh.factory<_i892.CreateUserUseCase>(
      () => _i892.CreateUserUseCase(gh<_i450.IUserRepository>()),
    );
    gh.factory<_i214.UserExistsUseCase>(
      () => _i214.UserExistsUseCase(gh<_i450.IUserRepository>()),
    );
    gh.factory<_i91.GetUserUseCase>(
      () => _i91.GetUserUseCase(gh<_i450.IUserRepository>()),
    );
    gh.lazySingleton<_i0.IHomeRepository>(
      () => _i76.HomeRepositoryImpl(
        gh<_i65.IHomeUploadStorageRemoteDataSource>(),
        gh<_i1070.IHomePostRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i787.IAuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i25.IAuthRemoteDataSource>(),
        gh<_i281.ErrorHandler>(),
      ),
    );
    gh.factory<_i430.UserCubit>(
      () => _i430.UserCubit(gh<_i91.GetUserUseCase>()),
    );
    gh.factory<_i965.GetProfileUseCase>(
      () => _i965.GetProfileUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i727.ProfileDeletePostUseCase>(
      () => _i727.ProfileDeletePostUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i182.UpdateProfileBioUseCase>(
      () => _i182.UpdateProfileBioUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i643.UpdateProfileNameUseCase>(
      () => _i643.UpdateProfileNameUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i813.UploadProfileImageUseCase>(
      () => _i813.UploadProfileImageUseCase(gh<_i364.IProfileRepository>()),
    );
    gh.factory<_i992.CreatePostUseCase>(
      () => _i992.CreatePostUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i1006.DeletePostUseCase>(
      () => _i1006.DeletePostUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i994.GetDefaultPostsUseCase>(
      () => _i994.GetDefaultPostsUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i457.UploadPostMediaToTableUseCase>(
      () => _i457.UploadPostMediaToTableUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i251.UploadPostMediaUseCase>(
      () => _i251.UploadPostMediaUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i444.AddReactionUseCase>(
      () => _i444.AddReactionUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i761.GetUserReactionUseCase>(
      () => _i761.GetUserReactionUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i948.RemoveReactionUseCase>(
      () => _i948.RemoveReactionUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i724.GetReactionUseCase>(
      () => _i724.GetReactionUseCase(gh<_i0.IHomeRepository>()),
    );
    gh.factory<_i715.HomeCubit>(
      () => _i715.HomeCubit(
        gh<_i251.UploadPostMediaUseCase>(),
        gh<_i992.CreatePostUseCase>(),
        gh<_i457.UploadPostMediaToTableUseCase>(),
        gh<_i1006.DeletePostUseCase>(),
        gh<_i994.GetDefaultPostsUseCase>(),
      ),
    );
    gh.factory<_i771.ProfileCubit>(
      () => _i771.ProfileCubit(
        gh<_i643.UpdateProfileNameUseCase>(),
        gh<_i965.GetProfileUseCase>(),
        gh<_i813.UploadProfileImageUseCase>(),
        gh<_i727.ProfileDeletePostUseCase>(),
        gh<_i182.UpdateProfileBioUseCase>(),
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
    gh.singleton<_i235.AuthCubit>(
      () =>
          _i235.AuthCubit(gh<_i244.FirebaseClient>(), gh<_i48.LogoutUseCase>()),
    );
    gh.factory<_i24.SignupCubit>(
      () => _i24.SignupCubit(
        gh<_i57.SignupUseCase>(),
        gh<_i892.CreateUserUseCase>(),
      ),
    );
    gh.factory<_i1019.LoginCubit>(
      () => _i1019.LoginCubit(gh<_i188.LoginUseCase>()),
    );
    gh.singleton<_i997.MainCubit>(
      () => _i997.MainCubit(
        gh<_i253.ThemeCubit>(),
        gh<_i223.LocaleCubit>(),
        gh<_i235.AuthCubit>(),
        gh<_i430.UserCubit>(),
        gh<_i244.FirebaseClient>(),
      ),
    );
    gh.factory<_i739.VerificationCubit>(
      () => _i739.VerificationCubit(
        gh<_i104.EmailVerifiedUseCase>(),
        gh<_i699.SendEmailVerificationUserCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
