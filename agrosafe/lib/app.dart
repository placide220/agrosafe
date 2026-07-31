import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'screens/auth/splash_page.dart';
import 'features/crop_incident/presentation/bloc/incident_bloc.dart';
import 'features/settings_profile/presentation/cubit/settings_cubit.dart';
import 'features/settings_profile/presentation/cubit/settings_state.dart';
import 'features/weather_calendar/presentation/cubit/advisory_cubit.dart';

class AgroSafeApp extends StatelessWidget {
  const AgroSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<IncidentBloc>(create: (_) => sl<IncidentBloc>()),
        BlocProvider<AdvisoryCubit>(create: (_) => sl<AdvisoryCubit>()),
        BlocProvider<SettingsCubit>(create: (_) => sl<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          final settings = settingsState.settings;

          ThemeMode themeMode;
          switch (settings.themeMode) {
            case 'light':
              themeMode = ThemeMode.light;
              break;
            case 'dark':
              themeMode = ThemeMode.dark;
              break;
            default:
              themeMode = ThemeMode.system;
          }

          return MaterialApp(
            title: 'AgroSafe',
            debugShowCheckedModeBanner: false,
            theme: settings.isHighContrast
                ? AppTheme.highContrastTheme
                : AppTheme.lightTheme,
            darkTheme: settings.isHighContrast
                ? AppTheme.highContrastTheme
                : AppTheme.darkTheme,
            themeMode: themeMode,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
