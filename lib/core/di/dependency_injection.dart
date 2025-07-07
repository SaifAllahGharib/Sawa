import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../shared/helpers/shared_preferences_helper.dart';
import '../shared/viewmodel/cubits/locale_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton(() => SharedPreferencesHelper(Logger()));

  // Cubits
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<SharedPreferencesHelper>()),
  );
}
