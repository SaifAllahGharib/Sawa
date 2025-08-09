import 'dart:async';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/dependency_injection.dart';
import 'core/init/init_app.dart';
import 'core/routing/app_route_name.dart';
import 'core/routing/app_router.dart';
import 'core/shared/cubits/main/main_cubit.dart';
import 'core/shared/cubits/main/main_state.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_error_listener.dart';
import 'core/widgets/app_responsive_builder.dart';
import 'generated/l10n.dart';

void main() async {
  await initializeApp();

  FlutterError.onError = (FlutterErrorDetails details) async {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    debugPrint('[FlutterError] ${details.exceptionAsString()}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    debugPrint('[PlatformError] $error');
    return true;
  };

  runZonedGuarded<Future<void>>(
    () async {
      runApp(const SocialMediaApp());
    },
    (error, stack) async {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: false,
      );
      debugPrint('[ZonedError] $error');
    },
  );
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveBuilder(
      builder: (context) => BlocProvider(
        create: (context) => getIt<MainCubit>()..checkAuthStatus(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: state.themeMode,
              initialRoute: AppRouteName.splash,
              onGenerateRoute: AppRouter.generateRoute,
              builder: (context, child) => AppErrorListener(child: child!),
            );
          },
        ),
      ),
    );
  }
}
