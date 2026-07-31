import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String farmLocation,
  });

  Future<Either<Failure, UserEntity>> loginAsGuest();

  /// Sends a password-reset email to [email] via Firebase Auth.
  Future<Either<Failure, void>> sendPasswordReset({required String email});

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
