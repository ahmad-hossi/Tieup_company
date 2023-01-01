import 'package:tieup_company/core/error/exceptions.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:tieup_company/features/authentication/domain/repositories/authentication_repositry.dart';
import 'package:dartz/dartz.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try{
      final response = await _remoteDataSource.userLogin(email, password);
      return Right(response);
    }
    on UnauthorisedException {
      return const Left(Failure(errorType: ErrorType.unauthorisedError));
    }
    on ServerException{
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }

  @override
  Future<Either<Failure, bool>> signUpUser(Map<String, dynamic> body) async{
    try{
      final response = await _remoteDataSource.userSignUp(body);
      return Right(response);
    }
    on AlreadyExistsException {
      return const Left(Failure(errorType: ErrorType.alreadyExists));
    }
    on ServerException{
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }
}
