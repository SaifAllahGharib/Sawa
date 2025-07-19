import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern_intelligence_social_media_application/core/routing/app_route_name.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_state.dart';

import 'core/di/dependency_injection.dart';
import 'core/init/init_app.dart';
import 'core/routing/app_router.dart';
import 'core/shared/cubits/locale_cubit.dart';
import 'core/shared/cubits/theme_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/enums.dart';
import 'core/widgets/responsive_builder.dart';
import 'features/user/presentation/cubit/user/user_cubit.dart';
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
          BlocProvider(
            create: (context) => getIt<AuthCubit>()..checkAuthStatus(),
          ),
          BlocProvider(create: (context) => getIt<UserCubit>()),
        ],
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, theme) {
                return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, auth) {
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
                      initialRoute: (auth.status == AuthStatus.authenticated)
                          ? AppRouteName.home
                          : AppRouteName.login,
                      onGenerateRoute: AppRouter.generateRoute,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
