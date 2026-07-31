import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/incident_entity.dart';
import '../repositories/incident_repository.dart';

class GetIncidentsUseCase implements UseCase<List<IncidentEntity>, String> {
  final IncidentRepository repository;

  GetIncidentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentEntity>>> call(String userId) {
    return repository.getIncidents(userId);
  }
}
