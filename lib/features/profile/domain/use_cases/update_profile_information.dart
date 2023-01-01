import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';
import '../../../../core/entities/company_params.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileInformation extends UseCase<bool, CompanyParams> {
  ProfileRepository repository;
  UpdateProfileInformation(this.repository);

  @override
  Future<Either<Failure, bool>> call(CompanyParams params) {
    return repository.updateProfileInformation(params.toJson());
  }
}
