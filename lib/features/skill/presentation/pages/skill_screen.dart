import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tieup_company/constants.dart';
import 'package:tieup_company/core/constants/font_style.dart';
import 'package:tieup_company/core/widgets/default_button.dart';
import 'package:tieup_company/features/skill/domain/entities/skill.dart';
import 'package:tieup_company/features/skill/presentation/Bloc/skill_bloc.dart';
import 'package:tieup_company/features/skill/presentation/widgets/add_skills_dialog.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({Key? key}) : super(key: key);

  static const routeName = '/profile/skills';

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  bool enableEditing = false;
  List<Skill> userSkills = [];

  @override
  void initState() {
    context.read<SkillBloc>().add(GetUserSkillsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Skills'),
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: ScreenUtil().screenHeight - 80.h),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Adding all your work experience will increase your chances '
                    'to get the best job',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.1,
                    style: TextStyle(height: 1.5, color: kPrimaryColor),
                  ),
                  BlocConsumer<SkillBloc, SkillState>(
                    listener: (context, state) {
                      if (state is UserSkillsLoaded) {
                        userSkills = state.skills;
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSkillsLoaded) {
                        return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            child: Wrap(
                                spacing: 4.w,
                                runSpacing: 4.w,
                                direction: Axis.horizontal,
                                children: [
                                  ...List.generate(
                                    state.skills.length,
                                    (index) => Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: enableEditing
                                                    ? Colors.red
                                                    : kPrimaryColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(25.r)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              state.skills[index].name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            ...List.generate(
                                              state.skills[index].level ?? 0,
                                              (index) => Icon(
                                                Icons.star,
                                                size: 24,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            //Text('4'),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<SkillBloc>()
                                          .add(GetDomainsEvent());
                                      showDialog(
                                          context: context,
                                          builder: (_) => AddSkillsDialog(
                                                skillSection: true,
                                              )).then((value) => null);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            border: Border.all(
                                                color: kPrimaryColor, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(25.r)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Add more',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              ' +',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ),
                                ]));
                      }
                      return Container();
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 8.0),
                    child: DefaultButton(
                      text: enableEditing ? 'Save' : 'Edit',
                      press: () {
                        setState(() {
                          enableEditing = !enableEditing;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
