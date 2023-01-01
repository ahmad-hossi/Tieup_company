import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tieup_company/features/add_training/presentation/pages/add_training_screen.dart';

import 'features/add_job/presentation/pages/add_job_screen.dart';
import 'features/skill/presentation/Bloc/skill_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;


void main() {
  unawaited(di.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<SkillBloc>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,

              title: 'tieup company',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: AddTrainingScreen(),
            ),
          );
        });
  }
}
