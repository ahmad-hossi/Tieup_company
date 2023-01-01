import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tieup_company/features/add_job/data/data_sources/add_job_remote_data_source.dart';
import 'package:tieup_company/features/add_job/domain/repositories/add_job_repository.dart';
import 'package:tieup_company/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:tieup_company/features/profile/domain/repositories/profile_repository.dart';
import 'core/network/network_info.dart';
import 'features/add_job/data/repositories/add_job_repository_impl.dart';
import 'features/add_job/domain/use_cases/add_job.dart';
import 'features/add_job/presentation/bloc/job_add_bloc.dart';
import 'features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'features/authentication/data/repositories/authentication_repository_impl.dart';
import 'features/authentication/domain/repositories/authentication_repositry.dart';
import 'features/authentication/domain/use_cases/login_user.dart';
import 'features/authentication/domain/use_cases/signUp_user.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/loading/presentation/bloc/loading_cubit.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/use_cases/get_profile_information.dart';
import 'features/profile/domain/use_cases/update_company_image.dart';
import 'features/profile/domain/use_cases/update_profile_information.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/skill/data/data_sources/skill_remote_data_source.dart';
import 'features/skill/data/repositories/skill_repository_impl.dart';
import 'features/skill/domain/repositories/skill_repository.dart';
import 'features/skill/domain/use_cases/get_domains.dart';
import 'features/skill/domain/use_cases/get_skills.dart';
import 'features/skill/domain/use_cases/get_sub_domains.dart';
import 'features/skill/domain/use_cases/get_user_skills.dart';
import 'features/skill/presentation/Bloc/skill_bloc.dart';

final sl = GetIt.I;

Future init() async {
  // bloc

  sl.registerFactory(() => SkillBloc(
      getDomains: sl(),
      getSkills: sl(),
      getSubDomains: sl(),
      getUserSkills: sl()));

  sl.registerFactory(
    () => JobAddBloc(addJob: sl()),
  );

  // use cases
  sl.registerLazySingleton(() => GetDomains(sl()));
  sl.registerLazySingleton(() => GetSubDomains(sl()));
  sl.registerLazySingleton(() => GetSkills(sl()));
  sl.registerLazySingleton(() => GetUserSkills(sl()));
  sl.registerLazySingleton(() => AddJob(sl()));

  // Data sources
  sl.registerLazySingleton<SkillRemoteDataSource>(
      () => SkillRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AddJobRemoteDataSource>(
          () => AddJobRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<SkillRepository>(() => SkillRepositoryImpl(sl()));
  sl.registerLazySingleton<AddJobRepository>(() => AddJobRepositoryImpl(sl()));

  sl.registerFactory(() => AuthenticationBloc(
      loginUser: sl(), signUpUser: sl(), loadingCubit: sl()));
  sl.registerSingleton<LoadingCubit>(LoadingCubit());
  sl.registerFactory(() => ProfileBloc(
      getProfileInformation: sl(),
      updateProfileInformation: sl(),
      updateCompanyImage: sl()));

  // use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => SignUpUser(sl()));
  sl.registerLazySingleton(() => GetProfileInformation(sl()));
  sl.registerLazySingleton(() => UpdateProfileInformation(sl()));
  sl.registerLazySingleton(() => UpdateCompanyImage(sl()));

  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
