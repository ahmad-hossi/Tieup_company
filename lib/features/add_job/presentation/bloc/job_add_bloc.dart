import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/entities/add_jobs_params.dart';
import '../../domain/use_cases/add_job.dart';
part 'job_add_event.dart';
part 'job_add_state.dart';

class JobAddBloc extends Bloc<JobAddEvent, JobAddState> {
  AddJob addJob;

  JobAddBloc({required this.addJob}) : super(JobAddInitial()) {
    on<AddJobEvent>((event, emit) async {
      emit(JobAddLoading());
      final eitherResponse = await addJob(event.params);
      emit(eitherResponse.fold(
          (l) => JobAddFailed('errorMessage'), (r) => JobAddLoaded()));
    });
  }
}
