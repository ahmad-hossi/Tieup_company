import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tieup_company/core/entities/no_params.dart';
import 'package:tieup_company/features/profile/domain/entities/profile.dart';
import 'package:tieup_company/features/profile/domain/use_cases/get_profile_information.dart';

import '../../../../core/entities/company_params.dart';
import '../../../../core/entities/image_params.dart';
import '../../domain/use_cases/update_company_image.dart';
import '../../domain/use_cases/update_profile_information.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileInformation getProfileInformation;
  UpdateProfileInformation updateProfileInformation;
  UpdateCompanyImage updateCompanyImage;

  ProfileBloc(
      {required this.getProfileInformation,
        required this.updateCompanyImage,
      required this.updateProfileInformation})
      : super(ProfileInitial()) {
    on<GetCompanyProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final eitherResponse = await getProfileInformation(NoParams());
      emit(eitherResponse.fold((l) => ProfileFailed(errorMessage: 'error'),
          (userProfile) => ProfileLoaded(companyProfile: userProfile)));
    });

    on<UpdateCompanyProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final eitherResponse = await updateProfileInformation(event.params);
      emit(eitherResponse.fold((l) => ProfileFailed(errorMessage: 'error'),
              (success) => ProfileUpdatedSuccessfully()));
    });

    on<UpdateCompanyImageEvent>((event, emit) async {
      final imageResponse = await updateCompanyImage(event.params);
      print(imageResponse);
      if(imageResponse.isRight())
        {
          final eitherResponse = await getProfileInformation(NoParams());
          emit(eitherResponse.fold((l) => ProfileFailed(errorMessage: 'error'),
                  (userProfile) => ProfileLoaded(companyProfile: userProfile)));
        }
    });
  }
}
