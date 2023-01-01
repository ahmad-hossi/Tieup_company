import 'package:flutter/cupertino.dart';
import 'features/authentication/presentation/pages/login/login_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/profile/presentation/pages/edit_profile_screen.dart';
import 'features/profile/presentation/pages/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
