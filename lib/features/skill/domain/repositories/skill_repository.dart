import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:tieup_company/features/skill/domain/entities/domain.dart';
import 'package:tieup_company/features/skill/domain/entities/skill.dart';
import 'package:tieup_company/features/skill/domain/entities/sub_domain.dart';

abstract class SkillRepository {
  Future<Either<Failure, List<Domain>>> getDomains();
  Future<Either<Failure, List<SubDomain>>> getSubDomains(int id);
  Future<Either<Failure, List<Skill>>> getSkills(int id);
  Future<Either<Failure, List<Skill>>> getUserSkills();
}
