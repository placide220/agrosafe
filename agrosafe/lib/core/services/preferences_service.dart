import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constants.dart';

class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static Future<PreferencesService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  String getThemeMode() {
    return _prefs.getString(AppConstants.keyThemeMode) ?? 'system';
  }

  Future<bool> setThemeMode(String mode) async {
    return await _prefs.setString(AppConstants.keyThemeMode, mode);
  }

  String getLanguageCode() {
    return _prefs.getString(AppConstants.keyLanguage) ?? 'en';
  }

  Future<bool> setLanguageCode(String languageCode) async {
    return await _prefs.setString(AppConstants.keyLanguage, languageCode);
  }

  bool isHighContrastEnabled() {
    return _prefs.getBool(AppConstants.keyHighContrast) ?? false;
  }

  Future<bool> setHighContrastEnabled(bool enabled) async {
    return await _prefs.setBool(AppConstants.keyHighContrast, enabled);
  }
}
