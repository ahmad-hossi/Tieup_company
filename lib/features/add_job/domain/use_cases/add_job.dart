import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/core/use_cases/use_case.dart';

import '../../../../core/entities/add_jobs_params.dart';
import '../repositories/add_job_repository.dart';

class AddJob extends UseCase<bool, AddJobsParams> {
  AddJobRepository repository;
  AddJob(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddJobsParams params) {
    return repository.addJob(params.toJson());
  }
}
