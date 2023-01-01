import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tieup_company/core/widgets/default_button.dart';
import 'package:tieup_company/features/skill/domain/entities/skill.dart';
import 'package:tieup_company/features/skill/domain/entities/sub_domain.dart';

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
  List<String> militaryService = ['finished', 'postponed', 'in service',"don't matter"];
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

  String styleDropDownValue = 'part time';
  String typeDropDownValue = 'on-site';
  String militaryServiceDropDownValue = 'postponed';
  String cityDropDownValue = 'Aleppo';
  SubDomain selectedSubDomain = const SubDomain(id: 0, name: 'role') ;
  List<Skill> skills = [];
  List<String> descriptions = [];
  List<String> requirements = [];
  List<String> benefits = [];
  late List<DynamicWidget> dynamicDescriptionsList = [
    DynamicWidget(
      labelText: 'description',
      addDynamic: addDescriptionDynamic,
    ),
  ];
  late List<DynamicWidget> dynamicRequirementsList = [
    DynamicWidget(
        labelText: 'requirement',
        addDynamic: addRequirementsDynamic
    )
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

  submit() {
    descriptions.clear();
    for (var widget in dynamicDescriptionsList) {
      descriptions.add(widget.controller.text);
    }
    dynamicDescriptionsList.clear();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
        leading: const Padding(
          padding: EdgeInsets.all(14.0),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Job title'),
                            SizedBox(
                              width: 180.w,
                              height: 42.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Job title';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Job role'),
                            Text(selectedSubDomain.name),
                            TextButton(
                              onPressed: () {
                                context.read<SkillBloc>().add(GetDomainsEvent());
                                showDialog(context: context, builder: (_) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Vacancies number'),
                            SizedBox(
                              height: 42.h,
                              width: 150.w,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('City'),
                            DropdownButton(
                              value: cityDropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: cities.map((String city) {
                                return DropdownMenuItem(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  cityDropDownValue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Min requirement years'),
                            SizedBox(
                              width: 150.w,
                              height: 42.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Min requirement years';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Min requirement years",
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('High requirement years'),
                            SizedBox(
                              width: 150.w,
                              height: 42.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter High requirement years';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "High requirement years",
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Low salary'),
                            SizedBox(
                              width: 150.w,
                              height: 42.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Low salary';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Low salary",
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('High salary'),
                            SizedBox(
                              width: 150.w,
                              height: 42.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter High salary';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "High salary",
                                  border:  OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Min age",
                                      border:  OutlineInputBorder(),
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
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "High age",
                                      border:  OutlineInputBorder(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: selectedGender == Gender.female
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Military service'),
                              DropdownButton(
                                value: militaryServiceDropDownValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: militaryService.map((String military) {
                                  return DropdownMenuItem(
                                    value: military,
                                    child: Text(military),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    militaryServiceDropDownValue = newValue!;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Skills'),
                            TextButton(
                              onPressed: () {
                                context.read<SkillBloc>().add(GetDomainsEvent());
                                showDialog(context: context, builder: (_) {
                                  return AddSkillsDialog(skillSection: true,);
                                }).then((value) {
                                    skills = value;
                                });
                              },
                              style: TextButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blueAccent)),
                              child: const Text('add'),
                            ),
                          ],
                        ),
                        // SkillsSection(skills: skills),

                        DefaultButton(text: 'Add', press: submit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
