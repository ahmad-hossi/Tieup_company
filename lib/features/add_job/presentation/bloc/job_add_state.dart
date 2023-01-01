part of 'job_add_bloc.dart';

@immutable
abstract class JobAddState {}

class JobAddInitial extends JobAddState {}
class JobAddLoading extends JobAddState {}
class JobAddLoaded extends JobAddState {}
class JobAddFailed extends JobAddState {
 final  String errorMessage;
  JobAddFailed(this.errorMessage);
}

