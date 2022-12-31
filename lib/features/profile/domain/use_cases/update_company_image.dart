import 'package:dartz/dartz.dart';

import 'package:tieup_company/core/error/failures.dart';

import '../../../../core/entities/image_params.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/profile_repository.dart';

class UpdateCompanyImage extends UseCase<bool, ImageParams> {
  ProfileRepository repository;
  UpdateCompanyImage(this.repository);

  @override
  Future<Either<Failure, bool>> call(ImageParams params) {
    return repository.updateCompanyImage(params.imageFile, params.imageType,params.id);
  }
}
