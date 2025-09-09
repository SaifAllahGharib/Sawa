import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sawa/core/routing/app_route_name.dart';
import 'package:sawa/core/services/navigation/navigation_service.dart';

import 'core/di/dependency_injection.dart';
import 'core/init/init_app.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_responsive_builder.dart';
import 'generated/l10n.dart';
import 'shared/cubits/main/main_cubit.dart';
import 'shared/cubits/main/main_state.dart';

void main() async {
  await initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const SocialMediaApp(),
    ),
  );
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveBuilder(
      builder: (context) => BlocProvider.value(
        value: getIt<MainCubit>(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
              debugShowCheckedModeBanner: true,
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
              navigatorKey: NavigationService.I.navigatorKey,
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
