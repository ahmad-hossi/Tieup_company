import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/entities/no_params.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/core/use_cases/use_case.dart';
import 'package:tieup_company/features/skill/domain/entities/domain.dart';
import 'package:tieup_company/features/skill/domain/repositories/skill_repository.dart';

class GetDomains extends UseCase<List<Domain>, NoParams> {
  SkillRepository repository;
  GetDomains(this.repository);

  @override
  Future<Either<Failure, List<Domain>>> call(NoParams params) async {
    return await repository.getDomains();
  }
}
