import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthGuestLoginSubmitted>(_onGuestLoginSubmitted);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);
    on<AuthSignOutSubmitted>(_onSignOutSubmitted);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getCurrentUserUseCase(NoParams());
    result.fold((_) => emit(Unauthenticated()), (user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        farmLocation: event.farmLocation,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onGuestLoginSubmitted(
    AuthGuestLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    const guestUser = UserEntity(
      uid: 'guest_farmer_rw',
      email: 'guest@agrosafe.rw',
      fullName: 'Umuhinzi Mwiza (Guest)',
      role: 'Smallholder Farmer',
      farmLocation: 'Musanze District, Northern Province',
    );
    emit(const Authenticated(guestUser));
  }

  Future<void> _onPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase(
      ResetPasswordParams(email: event.email),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetSent(event.email)),
    );
  }

  Future<void> _onSignOutSubmitted(
    AuthSignOutSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await signOutUseCase(NoParams());
    emit(Unauthenticated());
  }
}
