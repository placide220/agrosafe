import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/advisory_entity.dart';

abstract class AdvisoryRepository {
  Future<Either<Failure, List<AdvisoryEntity>>> getAdvisories();
}
