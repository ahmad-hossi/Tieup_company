import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/exceptions.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:tieup_company/features/profile/domain/entities/profile.dart';
import 'package:tieup_company/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Profile>> getProfileInformation() async{
    try {
      final response = await remoteDataSource.getProfileInformation();
      return Right(response);
    } on UnauthenticatedException {
      return const Left(Failure(errorType: ErrorType.unauthenticated));
    } on ServerException {
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfileInformation(Map<String, dynamic> requestBody) async{
    try {
      final response = await remoteDataSource.updateProfileInformation(requestBody);
      return Right(response);
    } on UnauthenticatedException {
      return const Left(Failure(errorType: ErrorType.unauthenticated));
    } on ServerException {
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCompanyImage(File imageFile, String type,int companyId) async{
    try {
      final response = await remoteDataSource.updateCompanyImage(imageFile,type,companyId);
      return Right(response);
    } on UnauthenticatedException {
      return const Left(Failure(errorType: ErrorType.unauthenticated));
    } on ServerException {
      return const Left(Failure(errorType: ErrorType.serverError));
    }
  }

}