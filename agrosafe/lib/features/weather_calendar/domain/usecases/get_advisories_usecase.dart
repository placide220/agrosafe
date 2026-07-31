import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/advisory_entity.dart';
import '../repositories/advisory_repository.dart';

class GetAdvisoriesUseCase implements UseCase<List<AdvisoryEntity>, NoParams> {
  final AdvisoryRepository repository;

  GetAdvisoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<AdvisoryEntity>>> call(NoParams params) {
    return repository.getAdvisories();
  }
}
