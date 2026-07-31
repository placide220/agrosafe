import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/incident_entity.dart';
import '../repositories/incident_repository.dart';

class UpdateIncidentUseCase implements UseCase<IncidentEntity, IncidentEntity> {
  final IncidentRepository repository;

  UpdateIncidentUseCase(this.repository);

  @override
  Future<Either<Failure, IncidentEntity>> call(IncidentEntity incident) {
    return repository.updateIncident(incident);
  }
}
