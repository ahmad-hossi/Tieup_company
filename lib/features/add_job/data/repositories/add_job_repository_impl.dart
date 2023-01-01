import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/add_job_repository.dart';
import '../data_sources/add_job_remote_data_source.dart';

class AddJobRepositoryImpl implements AddJobRepository {
  AddJobRemoteDataSource remoteDataSource;
  AddJobRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, bool>> addJob(Map<String, dynamic> requestBody) async {
    try {
      return Right(await remoteDataSource.addJob(requestBody));
    } on UnauthenticatedException {
      return const Left(Failure(errorType: ErrorType.unauthenticated));
    } on ServerException {
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }
}
