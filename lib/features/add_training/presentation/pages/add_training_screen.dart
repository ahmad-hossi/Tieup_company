import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/dynamic_widget.dart';

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({Key? key}) : super(key: key);

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  final List<String> cities = [
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
  String cityDropDownValue = 'Aleppo';
  String startDate = '';
  List<String> descriptions = [];
  List<String> requirements = [];
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

  submit() {
    descriptions.clear();
    requirements.clear();
    for (var widget in dynamicDescriptionsList) {
      descriptions.add(widget.controller.text);
    }
    for (var widget in dynamicRequirementsList) {
      requirements.add(widget.controller.text);
    }
    dynamicDescriptionsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Training'),
        leading: const Padding(
          padding: EdgeInsets.all(14.0),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add your available training information',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Course name'),
                            SizedBox(
                              width: 180.w,
                              height: 42.h,
                              child: TextFormField(
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
                            const Text('Cost'),
                            SizedBox(
                              height: 42.h,
                              width: 180.w,
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
                            const Text('Address'),
                            SizedBox(
                              width: 180.w,
                              height: 42.h,
                              child: TextFormField(
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
                            const Text('Start Date'),
                            Text(startDate),
                            OutlinedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050))
                                    .then((value) => setState(() {
                                  startDate =
                                      DateFormat('yyyy/MM/dd').format(value!);
                                }));
                              },
                              child: const Text('Select date'),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('End Date'),
                            Text(startDate),
                            OutlinedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050))
                                    .then((value) => setState(() {
                                  startDate =
                                      DateFormat('yyyy/MM/dd').format(value!);
                                }));
                              },
                              child: const Text('Select date'),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Registration Date'),
                            Text(startDate),
                            OutlinedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2050))
                                    .then((value) => setState(() {
                                  startDate =
                                      DateFormat('yyyy/MM/dd').format(value!);
                                }));
                              },
                              child: const Text('Select date'),
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
                              width: 180.w,
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
                        DefaultButton(text: 'Add', press: submit)
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
