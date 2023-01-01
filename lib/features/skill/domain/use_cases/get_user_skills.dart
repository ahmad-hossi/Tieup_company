import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/entities/no_params.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/core/use_cases/use_case.dart';
import 'package:tieup_company/features/skill/domain/entities/skill.dart';
import 'package:tieup_company/features/skill/domain/repositories/skill_repository.dart';

class GetUserSkills extends UseCase<List<Skill>,NoParams>{
  SkillRepository repository;
  GetUserSkills(this.repository);

  @override
  Future<Either<Failure, List<Skill>>> call(NoParams params) {
    return repository.getUserSkills();
  }
}