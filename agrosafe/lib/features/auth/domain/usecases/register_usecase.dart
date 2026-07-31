import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return repository.registerWithEmail(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      farmLocation: params.farmLocation,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String farmLocation;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.farmLocation,
  });

  @override
  List<Object?> get props => [email, password, fullName, farmLocation];
}
