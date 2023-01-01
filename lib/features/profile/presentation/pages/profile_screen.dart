import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tieup_company/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tieup_company/features/profile/presentation/widgets/profile_pic.dart';
import 'package:tieup_company/core/constants/api_constant.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:app_settings/app_settings.dart';

import '../../../../core/entities/image_params.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../loading/presentation/bloc/loading_cubit.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/Profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  final ImagePicker _picker = ImagePicker();

  File? imageFile;

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetCompanyProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            color: Colors.black54,
          ),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ImageUpdatedFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('something went error')));
          }
        },
        builder: (context, state) {
          if(state is ProfileLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (state is ProfileFailed){
            return Center(child: Text(state.errorMessage));
          }
          else if (state is ProfileLoaded) {
            context.read<LoadingCubit>().hide();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _picker
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) {
                                  if (value != null) {
                                    context.read<ProfileBloc>().add(
                                        UpdateCompanyImageEvent(
                                            params: ImageParams(
                                                id: state.companyProfile.id,
                                                imageFile: File(value.path),
                                                imageType: 'companyCover')));
                                  }
                                });
                              },
                              child: SizedBox(
                                height: 128.h,
                                child:
                                    state.companyProfile.coverImageUrl == null
                                        ? Image.asset(
                                            'assets/images/place_holder.png',
                                            height: 128.h,
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/place_holder.png',
                                            image:
                                                '$kBaseUrl/${state.companyProfile.coverImageUrl}',
                                            height: 128.h,
                                            width: double.infinity,
                                            fit: BoxFit.fitHeight,
                                            imageErrorBuilder:
                                                (_, object, __) => Image.asset(
                                                    'assets/images/place_holder.png'),
                                          ),
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              padding: EdgeInsets.fromLTRB(80.w, 0, 0, 8.h),
                              height: 48.h,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  state.companyProfile.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/Mail.svg',
                                        width: 20,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(state.companyProfile.email),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/phone.svg',
                                        width: 20,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(state.companyProfile.phone),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  if (state.companyProfile.address != null &&
                                      state.companyProfile.cityName != null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/location.svg',
                                          width: 20,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                            '${state.companyProfile.address} , ${state.companyProfile.cityName}'),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  if (state.companyProfile.latitude != null &&
                                      state.companyProfile.longitude != null)
                                    GestureDetector(
                                        onTap: () async {
                                          final availableMaps =
                                              await MapLauncher.installedMaps;
                                          await availableMaps.first.showMarker(
                                              coords: Coords(
                                                  state
                                                      .companyProfile.latitude!,
                                                  state.companyProfile
                                                      .longitude!),
                                              title: state.companyProfile.name);
                                        },
                                        child: Image.asset(
                                            'assets/images/map.jpg')),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  if (state.companyProfile.description != null)
                                    Text(
                                      state.companyProfile.description!,
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  SizedBox(
                                    height: 8.h,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 20.w,
                        top: 68.h,
                        child: GestureDetector(
                          onTap: () async {
                            _picker
                                .pickImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                                context.read<ProfileBloc>().add(
                                    UpdateCompanyImageEvent(
                                        params: ImageParams(
                                            id: state.companyProfile.id,
                                            imageFile: File(value.path),
                                            imageType: 'companyProfile')));
                              }
                            });
                          },
                          child: ProfilePic(
                            imageUrl: state.companyProfile.imageUrl,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  DefaultButton(
                    text: 'edit',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditProfileScreen(
                                    companyProfile: state.companyProfile,
                                  )));
                    },
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
