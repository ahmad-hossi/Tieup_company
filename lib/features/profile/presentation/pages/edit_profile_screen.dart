import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tieup_company/core/widgets/default_button.dart';
import 'package:tieup_company/constants.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/entities/company_params.dart';
import '../../../loading/presentation/bloc/loading_cubit.dart';
import '../../../loading/presentation/pages/loading_circle.dart';
import '../../domain/entities/profile.dart';
import '../bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({required this.companyProfile, Key? key})
      : super(key: key);

  static const routeName = '/editProfile';
  final Profile companyProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    addressController =
        TextEditingController(text: widget.companyProfile.address);
    phoneController = TextEditingController(text: widget.companyProfile.phone);
    descriptionController =
        TextEditingController(text: widget.companyProfile.description);
    nameController = TextEditingController(text: widget.companyProfile.name);
    selectedCityId = widget.companyProfile.cityId;
    super.initState();
  }

  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController nameController;
  int? selectedCityId;
  Position? position;
  bool isLocated = false;

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
          selectedCityId = value!;
        });
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLocated = false;
      });
      AppSettings.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isLocated = false;
        });
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isLocated = false;
      });
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    setState(() {
      isLocated = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('location added successfully'),
    ));
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            color: Colors.black54,
          ),
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if(state is ProfileLoading){
            context.read<LoadingCubit>().show();
          }
          else if (state is ProfileUpdatedSuccessfully){
            context.read<LoadingCubit>().hide();
            Navigator.pop(context);
            context.read<ProfileBloc>().add(GetCompanyProfileEvent());
          } else if (state is ProfileFailed){
            context.read<LoadingCubit>().hide();
          } else {
            context.read<LoadingCubit>().hide();
          }
        },

        child: BlocBuilder<LoadingCubit, bool>(
          builder: (context, shouldShow) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      labelText: "Company name",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    //validator: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "phone number",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  TextFormField(
                                    controller: addressController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: "address",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  const Text('City'),
                                  citiesDropDown(),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  TextFormField(
                                    minLines: 3,
                                    maxLines: 6,
                                    controller: descriptionController,
                                    keyboardType: TextInputType.multiline,
                                    //validator: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Description",
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text('Tap to add current Location'),
                                  InkWell(
                                      onTap: () async {
                                        position = await _determinePosition();
                                      },
                                      child: SizedBox(
                                        height: 120,
                                        width: double.infinity,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            SizedBox(
                                                height: 120,
                                                width: double.infinity,
                                                child: Image.asset(
                                                  'assets/images/map.jpg',
                                                  fit: BoxFit.fitWidth,
                                                )),
                                            if (isLocated)
                                              Center(
                                                  child: SvgPicture.asset(
                                                    'assets/icons/location.svg',
                                                    width: 34,
                                                  )),
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultButton(
                          text: 'Save',
                          press: () {
                              context.read<ProfileBloc>().add(
                                UpdateCompanyProfileEvent(params: CompanyParams(
                                  cityId : selectedCityId! + 1,
                                  name : nameController.text,
                                  description : descriptionController.text,
                                  phone : phoneController.text,
                                  address : addressController.text,
                                  longitude : position!.longitude,
                                  latitude : position!.latitude,
                                ))
                              );
                          }),
                    )
                  ],
                ),
                if (shouldShow)
                  Container(
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.7)),
                    child: Center(
                      child: LoadingCircle(
                        size: 200.w,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
