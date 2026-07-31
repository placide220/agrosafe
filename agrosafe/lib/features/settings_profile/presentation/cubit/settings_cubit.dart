import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/settings_local_data_source.dart';
import '../../domain/entities/settings_entity.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsLocalDataSource localDataSource;

  SettingsCubit({required this.localDataSource})
    : super(
        SettingsState(
          SettingsEntity(
            languageCode: localDataSource.getSettings().languageCode,
            isHighContrast: localDataSource.getSettings().isHighContrast,
            themeMode: localDataSource.getSettings().themeMode,
          ),
        ),
      );

  Future<void> setLanguageCode(String code) async {
    final updated = state.settings.copyWith(languageCode: code);
    emit(SettingsState(updated));
    await _persist(updated);
  }

  Future<void> toggleHighContrast(bool value) async {
    final updated = state.settings.copyWith(isHighContrast: value);
    emit(SettingsState(updated));
    await _persist(updated);
  }

  Future<void> setThemeMode(String mode) async {
    final updated = state.settings.copyWith(themeMode: mode);
    emit(SettingsState(updated));
    await _persist(updated);
  }

  Future<void> _persist(SettingsEntity entity) async {
    await localDataSource.saveSettings(
      UserSettings(
        languageCode: entity.languageCode,
        isHighContrast: entity.isHighContrast,
        themeMode: entity.themeMode,
      ),
    );
  }
}
