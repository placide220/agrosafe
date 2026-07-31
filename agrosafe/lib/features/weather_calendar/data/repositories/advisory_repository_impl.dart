import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/advisory_entity.dart';
import '../../domain/repositories/advisory_repository.dart';
import '../datasources/advisory_remote_data_source.dart';

class AdvisoryRepositoryImpl implements AdvisoryRepository {
  final AdvisoryRemoteDataSource remoteDataSource;

  AdvisoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AdvisoryEntity>>> getAdvisories() async {
    try {
      final list = await remoteDataSource.getAdvisories();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
