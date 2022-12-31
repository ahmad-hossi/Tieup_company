import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/entities/no_params.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/core/use_cases/use_case.dart';
import 'package:tieup_company/features/profile/domain/entities/profile.dart';
import 'package:tieup_company/features/profile/domain/repositories/profile_repository.dart';

class GetProfileInformation extends UseCase<Profile,NoParams>{
  ProfileRepository repository;
  GetProfileInformation(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) {
    return repository.getProfileInformation();
  }

}