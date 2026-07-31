import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/incident_entity.dart';

abstract class IncidentRepository {
  Stream<List<IncidentEntity>> getIncidentsStream(String userId);
  Future<Either<Failure, List<IncidentEntity>>> getIncidents(String userId);
  Future<Either<Failure, IncidentEntity>> createIncident(
    IncidentEntity incident,
  );
  Future<Either<Failure, IncidentEntity>> updateIncident(
    IncidentEntity incident,
  );
  Future<Either<Failure, void>> deleteIncident(
    String incidentId,
    String userId,
  );
}
