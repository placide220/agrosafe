import 'package:agrosafe/features/settings_profile/data/datasources/settings_local_data_source.dart';
import 'package:agrosafe/features/settings_profile/presentation/cubit/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsLocalDataSource extends Mock
    implements SettingsLocalDataSource {}

class FakeUserSettings extends Fake implements UserSettings {}

void main() {
  late SettingsCubit cubit;
  late MockSettingsLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserSettings());
  });

  setUp(() {
    mockLocalDataSource = MockSettingsLocalDataSource();
    when(
      () => mockLocalDataSource.getSettings(),
    ).thenReturn(const UserSettings());

    cubit = SettingsCubit(localDataSource: mockLocalDataSource);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state has default settings', () {
    expect(cubit.state.settings.languageCode, equals('rw'));
    expect(cubit.state.settings.isHighContrast, equals(false));
    expect(cubit.state.settings.themeMode, equals('system'));
  });

  test('setLanguageCode updates state and persists settings', () async {
    when(
      () => mockLocalDataSource.saveSettings(any()),
    ).thenAnswer((_) async {});

    await cubit.setLanguageCode('en');

    expect(cubit.state.settings.languageCode, equals('en'));
    verify(() => mockLocalDataSource.saveSettings(any())).called(1);
  });
}
