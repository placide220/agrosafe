import 'package:agrosafe/core/usecase/usecase.dart';
import 'package:agrosafe/features/auth/domain/entities/user_entity.dart';
import 'package:agrosafe/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/login_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/register_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:agrosafe/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:agrosafe/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:agrosafe/features/auth/presentation/bloc/auth_event.dart';
import 'package:agrosafe/features/auth/presentation/bloc/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class FakeLoginParams extends Fake implements LoginParams {}

class FakeNoParams extends Fake implements NoParams {}

class FakeResetPasswordParams extends Fake implements ResetPasswordParams {}

void main() {
  late AuthBloc bloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeResetPasswordParams());
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();

    bloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      signOutUseCase: mockSignOutUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tUser = UserEntity(
    uid: 'user_001',
    email: 'farmer@agrosafe.rw',
    fullName: 'Claudine Uwimana',
    role: 'Smallholder Farmer',
    farmLocation: 'Musanze District',
  );

  test('initial state is AuthInitial', () {
    expect(bloc.state, isA<AuthInitial>());
  });

  test(
    'emits [AuthLoading, Authenticated] on successful LoginSubmitted',
    () async {
      when(
        () => mockLoginUseCase(any()),
      ).thenAnswer((_) async => const Right(tUser));

      final expected = [isA<AuthLoading>(), isA<Authenticated>()];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(
        const AuthLoginSubmitted(
          email: 'farmer@agrosafe.rw',
          password: 'password123',
        ),
      );
    },
  );

  test(
    'emits [AuthLoading, Unauthenticated] on successful SignOutSubmitted',
    () async {
      when(
        () => mockSignOutUseCase(any()),
      ).thenAnswer((_) async => const Right(null));

      final expected = [isA<AuthLoading>(), isA<Unauthenticated>()];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(AuthSignOutSubmitted());
    },
  );

  test(
    'emits [AuthLoading, AuthPasswordResetSent] on successful reset request',
    () async {
      when(
        () => mockResetPasswordUseCase(any()),
      ).thenAnswer((_) async => const Right(null));

      final expected = [isA<AuthLoading>(), isA<AuthPasswordResetSent>()];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const AuthPasswordResetRequested(email: 'farmer@agrosafe.rw'));
    },
  );
}
