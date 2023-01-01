part of 'job_add_bloc.dart';

@immutable
abstract class JobAddEvent {}


class AddJobEvent extends JobAddEvent{
  final AddJobsParams params;
  AddJobEvent({required this.params});
}