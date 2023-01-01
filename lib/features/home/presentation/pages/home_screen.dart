import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tieup_company/constants.dart';
import 'package:tieup_company/core/constants/api_constant.dart';
import 'package:tieup_company/core/widgets/custom_nav_bar.dart';
import 'package:tieup_company/core/widgets/no_account_text.dart';
import 'package:tieup_company/core/constants/enums.dart';
import 'package:tieup_company/features/home/presentation/bloc/home_bloc.dart';
import 'package:badges/badges.dart';

import '../../../add_job/presentation/pages/add_job_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // void initState() {
  //   context.read<HomeBloc>().add(GetAllCompaniesEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/menu-left.svg',
                    color: Color(0xff364965),
                    width: 34.w,
                    height: 34.h,
                  )),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: Color(0xff364965),
                      width: 34.w,
                      height: 34.h,
                    )),
                // IconButton(
                //     onPressed: () {},
                //     icon: Badge(
                //       badgeContent: Text(
                //         '3',
                //         style: TextStyle(color: Colors.white, fontSize: 12),
                //       ),
                //       padding: EdgeInsets.all(4),
                //       position: BadgePosition(bottom: 16, start: 14),
                //       child: SvgPicture.asset(
                //         'assets/icons/notification.svg',
                //         color: Color(0xff364965),
                //         width: 34.w,
                //         height: 34.h,
                //       ),
                //     )),
              ],
              centerTitle: true,
              title: Image.asset(
                'assets/images/logo_text.png',
                width: 120.w,
                color: kPrimaryColor,
              )
              // const Text('TIEUP',style: TextStyle(
              //     color: kPrimaryColor,
              //     fontSize: 32,
              //     letterSpacing: 6,
              //     fontWeight: FontWeight.w500),)
              ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 150,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          'Add New Training',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        )),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AddJobScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 150,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          'Add New Job',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        )),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: CustomNavBar(
            menuState: MenuState.home,
          )),
    );
  }
}
