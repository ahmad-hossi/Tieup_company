part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile companyProfile;
  ProfileLoaded({required this.companyProfile});
}

class ProfileFailed extends ProfileState {
  final String errorMessage;
  ProfileFailed({required this.errorMessage});
}

class ProfileUpdatedSuccessfully extends ProfileState{}

class ImageUpdatedFailed extends ProfileState{}

