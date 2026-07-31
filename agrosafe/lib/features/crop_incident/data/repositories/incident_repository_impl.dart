import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/repositories/incident_repository.dart';
import '../datasources/incident_remote_data_source.dart';
import '../models/incident_model.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final IncidentRemoteDataSource remoteDataSource;

  IncidentRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<IncidentEntity>> getIncidentsStream(String userId) {
    return remoteDataSource.getIncidentsStream(userId);
  }

  @override
  Future<Either<Failure, List<IncidentEntity>>> getIncidents(
    String userId,
  ) async {
    try {
      final list = await remoteDataSource.getIncidents(userId);
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, IncidentEntity>> createIncident(
    IncidentEntity incident,
  ) async {
    try {
      final model = IncidentModel.fromEntity(incident);
      final created = await remoteDataSource.createIncident(model);
      return Right(created);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, IncidentEntity>> updateIncident(
    IncidentEntity incident,
  ) async {
    try {
      final model = IncidentModel.fromEntity(incident);
      final updated = await remoteDataSource.updateIncident(model);
      return Right(updated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncident(
    String incidentId,
    String userId,
  ) async {
    try {
      await remoteDataSource.deleteIncident(incidentId, userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
