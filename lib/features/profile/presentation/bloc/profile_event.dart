part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetCompanyProfileEvent extends ProfileEvent{}

class UpdateCompanyProfileEvent extends ProfileEvent{
  final CompanyParams params;
  UpdateCompanyProfileEvent({required this.params});
}


class UpdateCompanyImageEvent extends ProfileEvent{
  final ImageParams params;
  UpdateCompanyImageEvent({required this.params});
}