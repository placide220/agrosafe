class AppConstants {
  static const String appName = 'AgroSafe';
  static const String appTagline = 'Smart Agricultural Safety & Advisory';

  // SharedPreferences Keys
  static const String keyThemeMode = 'theme_mode'; // 'system', 'light', 'dark'
  static const String keyLanguage = 'language_code'; // 'en', 'rw'
  static const String keyHighContrast = 'high_contrast_enabled';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String incidentsCollection = 'incidents';
  static const String advisoriesCollection = 'advisories';
}
