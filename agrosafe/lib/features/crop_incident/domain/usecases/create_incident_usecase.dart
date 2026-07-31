import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/incident_entity.dart';
import '../repositories/incident_repository.dart';

class CreateIncidentUseCase implements UseCase<IncidentEntity, IncidentEntity> {
  final IncidentRepository repository;

  CreateIncidentUseCase(this.repository);

  @override
  Future<Either<Failure, IncidentEntity>> call(IncidentEntity incident) {
    return repository.createIncident(incident);
  }
}
