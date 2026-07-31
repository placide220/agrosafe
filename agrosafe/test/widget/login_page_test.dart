import 'package:agrosafe/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/login_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/register_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:agrosafe/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:agrosafe/screens/auth/login_page.dart';
import 'package:agrosafe/features/settings_profile/data/datasources/settings_local_data_source.dart';
import 'package:agrosafe/features/settings_profile/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class MockSettingsLocalDataSource extends Mock
    implements SettingsLocalDataSource {}

void main() {
  late AuthBloc authBloc;
  late SettingsCubit settingsCubit;
  late MockSettingsLocalDataSource mockSettingsDataSource;

  setUp(() {
    authBloc = AuthBloc(
      loginUseCase: MockLoginUseCase(),
      registerUseCase: MockRegisterUseCase(),
      signOutUseCase: MockSignOutUseCase(),
      getCurrentUserUseCase: MockGetCurrentUserUseCase(),
      resetPasswordUseCase: MockResetPasswordUseCase(),
    );

    mockSettingsDataSource = MockSettingsLocalDataSource();
    when(() => mockSettingsDataSource.getSettings()).thenReturn(
      const UserSettings(
        languageCode: 'en',
        isHighContrast: false,
        themeMode: 'system',
      ),
    );

    settingsCubit = SettingsCubit(localDataSource: mockSettingsDataSource);
  });

  tearDown(() {
    authBloc.close();
    settingsCubit.close();
  });

  testWidgets('LoginPage renders welcome title and login fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
        ],
        child: const MaterialApp(home: LoginPage()),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
