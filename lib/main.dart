import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern_intelligence_social_media_application/core/routing/app_route_name.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/main/main_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/main/main_state.dart';

import 'core/di/dependency_injection.dart';
import 'core/init/init_app.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/responsive_builder.dart';
import 'generated/l10n.dart';

void main() async {
  await initializeApp();
  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context) => BlocProvider(
        create: (context) => getIt<MainCubit>()..checkAuthStatus(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
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
            );
          },
        ),
      ),
    );
  }
}
