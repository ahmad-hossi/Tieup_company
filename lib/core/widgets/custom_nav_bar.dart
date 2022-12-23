import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tieup_company/constants.dart';
import 'package:tieup_company/core/constants/custom_icon.dart';
import 'package:tieup_company/core/constants/enums.dart';


class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key, required this.menuState}) : super(key: key);
  final MenuState menuState;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 2)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                CustomIcons.home,
                color: kPrimaryColor,
                height: 34.h,
              ),
              Text('Home')
            ],
          ),
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, JobScreen.routeName);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  CustomIcons.home,
                  color: kPrimaryColor,
                  height: 34.h,
                ),
                Text('All Jobs')
              ],
            ),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     SvgPicture.asset(
          //       CustomIcons.job,
          //       color: kPrimaryColor,
          //       height: 34.h,
          //     ),
          //     Text('Jobs')
          //   ],
          // ),
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, TrainingScreen.routeName);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  CustomIcons.job,
                  color: kPrimaryColor,
                  height: 34.h,
                ),
                const Text('All Trainings')
              ],
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, ProfileScreen.routeName);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  CustomIcons.profile,
                  color: kPrimaryColor,
                  height: 34.h,
                ),
                Text('Profile')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
