import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tieup_company/core/widgets/default_button.dart';
import 'package:tieup_company/features/add_job/presentation/bloc/job_add_bloc.dart';
import 'package:tieup_company/features/skill/domain/entities/skill.dart';
import 'package:tieup_company/features/skill/domain/entities/sub_domain.dart';

import '../../../../constants.dart';
import '../../../../core/entities/add_jobs_params.dart';
import '../../../../core/widgets/dynamic_widget.dart';
import '../../../../core/widgets/skills_section.dart';
import '../../../skill/presentation/Bloc/skill_bloc.dart';
import '../../../skill/presentation/widgets/add_skills_dialog.dart';

enum Gender { male, female, any }

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  Gender selectedGender = Gender.any;
  List<String> jobStyle = ['part time', 'full time'];
  List<String> jobType = ['on-site', 'remote', 'hybrid'];
  List<String> militaryService = [
    'finished',
    'postponed',
    'in service',
    "don't matter"
  ];
  List<String> cities = [
    'Aleppo',
    'Damascus',
    'Rif Dimashq',
    'Hama',
    'Homs',
    'Idlib',
    'Tartus',
    'Latakia',
    'Raqqah',
    'Quneitra',
    'Deir ez-Zor',
    'Hasakah',
    'Daraa',
    'As-Suwayda',
  ];

  DropdownButton<int> citiesDropDown() {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int i = 0; i < cities.length; i++) {
      var item = DropdownMenuItem(value: i, child: Text(cities[i]));
      dropDownItems.add(item);
    }
    return DropdownButton<int>(
      alignment: Alignment.center,
      isExpanded: true,
      value: selectedCityId,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCityId = value;
        });
      },
    );
  }

  String styleDropDownValue = 'part time';
  String typeDropDownValue = 'on-site';
  String militaryServiceDropDownValue = 'postponed';
  //String cityDropDownValue = 'Aleppo';
  SubDomain selectedSubDomain = const SubDomain(id: -1, name: 'role');
  List<Skill> skills = [];
  List<String> descriptions = [];
  List<String> requirements = [];
  List<String> benefits = [];
  List<String> errors = [];
  int? selectedCityId;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController vNum = TextEditingController();
  TextEditingController minYears = TextEditingController();
  TextEditingController maxYears = TextEditingController();
  TextEditingController lowSalary = TextEditingController();
  TextEditingController highSalary = TextEditingController();
  TextEditingController minAge = TextEditingController();
  TextEditingController maxAge = TextEditingController();

  late List<DynamicWidget> dynamicDescriptionsList = [
    DynamicWidget(
      labelText: 'description',
      addDynamic: addDescriptionDynamic,
    ),
  ];
  late List<DynamicWidget> dynamicRequirementsList = [
    DynamicWidget(labelText: 'requirement', addDynamic: addRequirementsDynamic)
  ];
  late List<DynamicWidget> dynamicBenefitsList = [
    DynamicWidget(
      labelText: 'benefit',
      addDynamic: addBenefitsDynamic,
    ),
  ];

  addDescriptionDynamic() {
    if (dynamicDescriptionsList.length >= 10) {
      return;
    }
    dynamicDescriptionsList.add(
      DynamicWidget(
        labelText: 'description',
        addDynamic: addDescriptionDynamic,
      ),
    );
    setState(() {});
  }

  addRequirementsDynamic() {
    if (dynamicRequirementsList.length >= 10) {
      return;
    }
    dynamicRequirementsList.add(
      DynamicWidget(
        labelText: 'requirement',
        addDynamic: addRequirementsDynamic,
      ),
    );
    setState(() {});
  }

  addBenefitsDynamic() {
    if (dynamicBenefitsList.length >= 10) {
      return;
    }
    dynamicBenefitsList.add(
      DynamicWidget(
        labelText: 'benefit',
        addDynamic: addBenefitsDynamic,
      ),
    );
    setState(() {});
  }

  String description = '';
  String requirement = '';
  String benefit = '';

  submit() {
    descriptions.clear();
    for (var widget in dynamicDescriptionsList) {
      description += '${widget.controller.text}*';
    }
    if (dynamicDescriptionsList.length != 1) {
      dynamicDescriptionsList.clear();
    }

    requirements.clear();
    for (var widget in dynamicRequirementsList) {
      requirement += '${widget.controller.text}*';
    }
    if (dynamicRequirementsList.length != 1) {
      dynamicRequirementsList.clear();
    }

    benefits.clear();
    for (var widget in dynamicBenefitsList) {
      benefit += '${widget.controller.text}*';
    }
    if (dynamicBenefitsList.length != 1) {
      dynamicBenefitsList.clear();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Add Job'),
        leading: const Padding(
          padding: EdgeInsets.all(14.0),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<JobAddBloc, JobAddState>(
        listener: (context, state) {
          if (state is JobAddLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('addedd successfully')));
          }
        },
        builder: (context, state) {
          if (state is JobAddLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Add your available job information',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Job title'),
                                  SizedBox(
                                    width: 180.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: jobTitleController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Job title';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Job role'),
                                  Text(selectedSubDomain.name),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<SkillBloc>()
                                          .add(GetDomainsEvent());
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AddSkillsDialog();
                                          }).then((value) {
                                        setState(() {
                                          selectedSubDomain = value;
                                        });
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.blueAccent)),
                                    child: const Text('add'),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Job style'),
                                  DropdownButton(
                                    value: styleDropDownValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: jobStyle.map((String jobStyle) {
                                      return DropdownMenuItem(
                                        value: jobStyle,
                                        child: Text(jobStyle),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        styleDropDownValue = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Job type'),
                                  DropdownButton(
                                    value: typeDropDownValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: jobType.map((String jobType) {
                                      return DropdownMenuItem(
                                        value: jobType,
                                        child: Text(jobType),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        typeDropDownValue = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Vacancies number'),
                                  SizedBox(
                                    height: 42.h,
                                    width: 150.w,
                                    child: TextFormField(
                                      controller: vNum,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('City'),
                                  SizedBox(width: 100, child: citiesDropDown()),
                                  // DropdownButton(
                                  //   value: cityDropDownValue,
                                  //   icon: const Icon(Icons.keyboard_arrow_down),
                                  //   items: cities.map((String city) {
                                  //     return DropdownMenuItem(
                                  //       value: city,
                                  //       child: Text(city),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (newValue) {
                                  //     setState(() {
                                  //       cityDropDownValue = newValue!;
                                  //     });
                                  //   },
                                  // ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Min requirement years'),
                                  SizedBox(
                                    width: 150.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: minYears,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Min requirement years';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Min requirement years",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('High requirement years'),
                                  SizedBox(
                                    width: 150.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: maxYears,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter High requirement years';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "High requirement years",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Low salary'),
                                  SizedBox(
                                    width: 150.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: lowSalary,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Low salary';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Low salary",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('High salary'),
                                  SizedBox(
                                    width: 150.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: highSalary,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter High salary';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "High salary",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Min age'),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        height: 42.h,
                                        child: TextFormField(
                                          controller: minAge,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: "Min age",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('High age'),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        height: 42.h,
                                        child: TextFormField(
                                          controller: maxAge,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: "High age",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('gender'),
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedGender = Gender.male;
                                          });
                                        },
                                        child: Row(children: [
                                          Icon(
                                            Icons.check_box_outlined,
                                            color: selectedGender == Gender.male
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                          ),
                                          const Text('Male'),
                                        ]),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedGender = Gender.female;
                                          });
                                        },
                                        child: Row(children: [
                                          Icon(
                                            Icons.check_box_outlined,
                                            color:
                                                selectedGender == Gender.female
                                                    ? Colors.blueAccent
                                                    : Colors.grey,
                                          ),
                                          const Text('Female'),
                                        ]),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedGender = Gender.any;
                                          });
                                        },
                                        child: Row(children: [
                                          Icon(
                                            Icons.check_box_outlined,
                                            color: selectedGender == Gender.any
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                          ),
                                          const Text('Any'),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              if (selectedGender == Gender.male)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Military service'),
                                    DropdownButton(
                                      value: militaryServiceDropDownValue,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: militaryService
                                          .map((String military) {
                                        return DropdownMenuItem(
                                          value: military,
                                          child: Text(military),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          militaryServiceDropDownValue =
                                              newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              if (selectedGender == Gender.male)
                                const Divider(
                                  color: Colors.grey,
                                ),
                              const Text('Description'),
                              SizedBox(height: 8.h),
                              ...dynamicDescriptionsList,
                              const Divider(
                                color: Colors.grey,
                              ),
                              const Text('Requirements'),
                              SizedBox(height: 8.h),
                              ...dynamicRequirementsList,
                              const Divider(
                                color: Colors.grey,
                              ),
                              const Text('Benefits'),
                              SizedBox(height: 8.h),
                              ...dynamicBenefitsList,
                              const Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Skills'),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<SkillBloc>()
                                          .add(GetDomainsEvent());
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AddSkillsDialog(
                                              skillSection: true,
                                            );
                                          }).then((value) {
                                        setState(() {
                                          skills.addAll(value);
                                        });
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.blueAccent)),
                                    child: const Text('add'),
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 4.w,
                                runSpacing: 4.w,
                                direction: Axis.horizontal,
                                children: List.generate(
                                  skills.length,
                                  (index) => Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kPrimaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(25.r)),
                                      child: Text(
                                        skills[index].name,
                                      )
                                      // child: const Center(child: Text('Team work',style: TextStyle(color: Colors.white),)),
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 64,
                                child: ListView.builder(
                                  itemBuilder: (_, index) => Text(
                                    errors[index],
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  itemCount: errors.length,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DefaultButton(
                                  text: 'Add',
                                  press: () {
                                    errors.clear();
                                    submit();
                                    if (selectedSubDomain.id == -1) {
                                      errors.add('you should choose job role');
                                    }
                                    if (selectedCityId == null &&
                                        typeDropDownValue != 'remote') {
                                      errors.add(
                                          'you should choose city if job type not remote');
                                    }
                                    if (minAge.text.isNotEmpty) {
                                      if (int.parse(minAge.text) < 18) {
                                        errors.add(
                                            'the min age should be greater than 18 years');
                                      }
                                    }
                                    if (maxAge.text.isNotEmpty) {
                                      if (int.parse(maxAge.text) < 18) {
                                        errors.add(
                                            'the max age should be greater than 18 years');
                                      }
                                    }
                                    if (description.isEmpty) {
                                      errors.add(
                                          'you should add at least one description');
                                    }
                                    if (requirement.isEmpty) {
                                      errors.add(
                                          'you should add at least one requirement');
                                    }
                                    if (benefit.isEmpty) {
                                      errors.add(
                                          'you should add at least one benefit');
                                    }
                                    setState(() {});
                                    if (_formKey.currentState!.validate()) {
                                      context.read<JobAddBloc>().add(AddJobEvent(
                                          params: AddJobsParams(
                                              cityId: selectedCityId! + 1,
                                              skills: skills,
                                              gender: selectedGender
                                                  .toString()
                                                  .substring(7),
                                              jobTitle: jobTitleController.text,
                                              jobStyle: styleDropDownValue,
                                              jobType: typeDropDownValue,
                                              militaryService:
                                                  militaryServiceDropDownValue,
                                              minAge: int.parse(minAge.text),
                                              maxAge: int.parse(maxAge.text),
                                              vacanciesNum:
                                                  int.parse(vNum.text),
                                              lowSalary:
                                                  int.parse(lowSalary.text),
                                              highSalary:
                                                  int.parse(highSalary.text),
                                              minYearsRequirement:
                                                  int.parse(minYears.text),
                                              maxYearsRequirement:
                                                  int.parse(maxYears.text),
                                              subdomainId: selectedSubDomain.id,
                                              description: description,
                                              requirement: requirement,
                                              benefits: benefit)));
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
          }
        },
      ),
    );
  }
}
