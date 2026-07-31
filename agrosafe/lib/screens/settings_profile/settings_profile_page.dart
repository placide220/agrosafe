import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/i18n_strings.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';
import '../auth/login_page.dart';

class SettingsProfilePage extends StatelessWidget {
  final UserEntity user;

  const SettingsProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();
    final settings = settingsCubit.state.settings;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(I18nStrings.get('settings', langCode(context))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      user.fullName.isNotEmpty
                          ? user.fullName.substring(0, 1).toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          backgroundColor: const Color(
                            0xFF1E5620,
                          ).withValues(alpha: 0.1),
                          label: Text(
                            '${user.role} • ${user.farmLocation}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E5620),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'PREFERENCES & ACCESSIBILITY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(
                      I18nStrings.get('language_option', settings.languageCode),
                    ),
                    subtitle: Text(
                      settings.languageCode == 'rw'
                          ? 'Kinyarwanda (Ururimi rw’Igihugu)'
                          : 'English (Default)',
                    ),
                    trailing: DropdownButton<String>(
                      value: settings.languageCode,
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(
                          value: 'rw',
                          child: Text('Kinyarwanda'),
                        ),
                      ],
                      onChanged: (newLang) {
                        if (newLang != null) {
                          settingsCubit.setLanguageCode(newLang);
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.contrast_outlined),
                    title: Text(
                      I18nStrings.get('high_contrast', settings.languageCode),
                    ),
                    subtitle: const Text(
                      'Enhance color readability for low vision',
                    ),
                    value: settings.isHighContrast,
                    onChanged: (val) {
                      settingsCubit.toggleHighContrast(val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'APPEARANCE THEME',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.light_mode_outlined),
                    title: const Text('Light Mode'),
                    trailing: settings.themeMode == 'light'
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFF1E5620),
                          )
                        : null,
                    onTap: () => settingsCubit.setThemeMode('light'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Dark Mode'),
                    trailing: settings.themeMode == 'dark'
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFF1E5620),
                          )
                        : null,
                    onTap: () => settingsCubit.setThemeMode('dark'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_suggest_outlined),
                    title: const Text('System Default'),
                    trailing: settings.themeMode == 'system'
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFF1E5620),
                          )
                        : null,
                    onTap: () => settingsCubit.setThemeMode('system'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.logout),
                label: Text(I18nStrings.get('logout', settings.languageCode)),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthSignOutSubmitted());
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String langCode(BuildContext context) {
    return context.read<SettingsCubit>().state.settings.languageCode;
  }
}
