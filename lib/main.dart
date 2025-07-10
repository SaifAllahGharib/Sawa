import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';

import 'core/di/dependency_injection.dart';
import 'core/init/init_app.dart';
import 'core/routing/app_router.dart';
import 'core/shared/cubits/locale_cubit.dart';
import 'core/shared/cubits/theme_cubit.dart';
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
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LocaleCubit>()),
          BlocProvider(create: (context) => getIt<ThemeCubit>()),
        ],
        child: BlocSelector<LocaleCubit, Locale, Locale>(
          selector: (locale) => locale,
          builder: (context, locale) {
            return BlocSelector<ThemeCubit, ThemeMode, ThemeMode>(
              selector: (theme) => theme,
              builder: (context, theme) {
                return MaterialApp(
                  locale: locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: theme,
                  initialRoute: getIt<SharedPreferencesHelper>().getInitRoute(),
                  onGenerateRoute: AppRouter.generateRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
