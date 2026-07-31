import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final String languageCode; // 'en', 'rw'
  final bool isHighContrast;
  final String themeMode; // 'light', 'dark', 'system'

  const SettingsEntity({
    this.languageCode = 'rw',
    this.isHighContrast = false,
    this.themeMode = 'system',
  });

  SettingsEntity copyWith({
    String? languageCode,
    bool? isHighContrast,
    String? themeMode,
  }) {
    return SettingsEntity(
      languageCode: languageCode ?? this.languageCode,
      isHighContrast: isHighContrast ?? this.isHighContrast,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [languageCode, isHighContrast, themeMode];
}
