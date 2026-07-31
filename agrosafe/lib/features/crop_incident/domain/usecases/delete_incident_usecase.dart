import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/incident_repository.dart';

class DeleteIncidentParams extends Equatable {
  final String incidentId;
  final String userId;

  const DeleteIncidentParams({required this.incidentId, required this.userId});

  @override
  List<Object?> get props => [incidentId, userId];
}

class DeleteIncidentUseCase implements UseCase<void, DeleteIncidentParams> {
  final IncidentRepository repository;

  DeleteIncidentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteIncidentParams params) {
    return repository.deleteIncident(params.incidentId, params.userId);
  }
}
