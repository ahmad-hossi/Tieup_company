import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tieup_company/features/add_training/presentation/pages/add_training_screen.dart';
import 'features/add_job/presentation/pages/add_job_screen.dart';
import 'features/skill/presentation/Bloc/skill_bloc.dart';
import 'package:tieup_company/routes.dart';
import 'constants.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/pages/login/login_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/loading/presentation/bloc/loading_cubit.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';



void main() {
  unawaited(di.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthenticationBloc>()),
            BlocProvider(create: (_) => sl<LoadingCubit>()),
            BlocProvider(create: (_) => sl<ProfileBloc>()),
            BlocProvider(create: (_) => sl<SkillBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Color(0xFFF8F8F8),
                elevation: 0,
                titleTextStyle: TextStyle(color: Color(0xFF364965),
                  fontSize: 24,
                ),
              ),
              // primarySwatch: const MaterialColor(0x3E58CC,<int,Color>{
              //   400:Color(0x00455fcf),
              //   300:Color(0x006378d5),
              //   200:Color(0x009aa8e4),
              //   100:Color(0x00d4dbf4),
              // }),
              primaryColor: kPrimaryColor,
              //useMaterial3: true,
              // fontFamily: 'Gilroy'
            ),
            //home: HomeScreen(),
            routes: routes,
            initialRoute: LoginScreen.routeName,
          ),
        );
      },
    );
  }
}
