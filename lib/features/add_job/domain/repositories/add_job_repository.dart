


import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';

abstract class AddJobRepository {
   Future<Either<Failure,bool>> addJob(Map<String,dynamic> requestBody);
}