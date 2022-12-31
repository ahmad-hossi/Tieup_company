import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfileInformation();
  Future<Either<Failure, bool>> updateProfileInformation(
      Map<String, dynamic> requestBody);
  Future<Either<Failure, bool>> updateCompanyImage(File imageFile, String type,int companyId);
}
