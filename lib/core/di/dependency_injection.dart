import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../helpers/shared_preferences_helper.dart';
import '../shared/cubits/locale_cubit.dart';
import '../shared/cubits/theme_cubit.dart';
import '../shared/cubits/validation/validation_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton(() => SharedPreferencesHelper(Logger()));

  // Cubits
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<SharedPreferencesHelper>()),
  );

  getIt.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(getIt<SharedPreferencesHelper>()),
  );

  getIt.registerFactory<ValidationCubit>(() => ValidationCubit());
}
