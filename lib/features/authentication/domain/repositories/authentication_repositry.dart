import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';

abstract class AuthenticationRepository{
  Future<Either<Failure,bool>> loginUser(String email,String password);
  Future<Either<Failure,bool>> signUpUser(Map<String , dynamic > body);
}