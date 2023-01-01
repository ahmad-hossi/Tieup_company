import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import '../../features/skill/domain/entities/skill.dart';

@JsonSerializable()
class AddJobsParams {
  @JsonKey(name: 'city_id')
  final int cityId;
  @JsonKey(name: 'sub_domain_id')
  final int subdomainId;
  @JsonKey(name: 'job_tite')
  final String jobTitle;
  @JsonKey(name: 'job_type')
  final String jobType;
  @JsonKey(name: 'job_style')
  final String jobStyle;
  @JsonKey(name: 'min_years_requirment')
  final int? minYearsRequirement;
  @JsonKey(name: 'max_years_requirment')
  final int? maxYearsRequirement;
  @JsonKey(name: 'low_salary')
  final int? lowSalary;
  @JsonKey(name: 'high_salary')
  final int? highSalary;
  @JsonKey(name: 'min_age')
  final int? minAge;
  @JsonKey(name: 'max_age')
  final int? maxAge;
  @JsonKey(name: 'discrip')
  final String description;
  @JsonKey(name: 'requirment')
  final String requirement;
  @JsonKey(name: 'benefit')
  final String? benefits;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'military_service')
  final String? militaryService;
  @JsonKey(name: 'vacancies_num')
  final int? vacanciesNum;
  final List<Skill> skills;

  AddJobsParams(
      {required this.cityId,
      required this.subdomainId,
      required this.jobTitle,
      required this.jobType,
      required this.jobStyle,
      this.minYearsRequirement,
      this.maxYearsRequirement,
      this.lowSalary,
      this.highSalary,
      this.minAge,
      this.maxAge,
      required this.description,
      required this.requirement,
      this.benefits,
      required this.gender,
      this.militaryService,
      this.vacanciesNum,
      required this.skills});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'city_id': cityId.toString(),
        'sub_domain_id': subdomainId.toString(),
        'job_tite': jobTitle,
        'job_type': jobType,
        'job_style': jobStyle,
        'min_years_requirment': minYearsRequirement.toString(),
        'max_years_requirment': maxYearsRequirement.toString(),
        'low_salary': lowSalary.toString(),
        'high_salary': highSalary.toString(),
        'min_age': minAge.toString(),
        'max_age': maxAge.toString(),
        'discrip': description,
        'requirment': requirement,
        'benefit': benefits,
        'gender': gender,
        'military_service': militaryService,
        'vacancies_num': vacanciesNum.toString(),
        for (int i = 0; i < skills.length; i++) ...{
          'skills[$i][skill_id]': '${skills[i].id}',
        }
      };
}
