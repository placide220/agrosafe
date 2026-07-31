import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  final String languageCode;
  final bool isHighContrast;
  final String themeMode;

  const UserSettings({
    this.languageCode = 'rw',
    this.isHighContrast = false,
    this.themeMode = 'system',
  });
}

abstract class SettingsLocalDataSource {
  UserSettings getSettings();
  Future<void> saveSettings(UserSettings settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const _keyLanguage = 'agrosafe_lang';
  static const _keyHighContrast = 'agrosafe_contrast';
  static const _keyThemeMode = 'agrosafe_theme';

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserSettings getSettings() {
    return UserSettings(
      languageCode: sharedPreferences.getString(_keyLanguage) ?? 'rw',
      isHighContrast: sharedPreferences.getBool(_keyHighContrast) ?? false,
      themeMode: sharedPreferences.getString(_keyThemeMode) ?? 'system',
    );
  }

  @override
  Future<void> saveSettings(UserSettings settings) async {
    await sharedPreferences.setString(_keyLanguage, settings.languageCode);
    await sharedPreferences.setBool(_keyHighContrast, settings.isHighContrast);
    await sharedPreferences.setString(_keyThemeMode, settings.themeMode);
  }
}
