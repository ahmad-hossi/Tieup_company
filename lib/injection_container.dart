import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
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



  // use cases
  sl.registerLazySingleton(() => GetDomains(sl()));
  sl.registerLazySingleton(() => GetSubDomains(sl()));
  sl.registerLazySingleton(() => GetSkills(sl()));
  sl.registerLazySingleton(() => GetUserSkills(sl()));


  // Data sources
  sl.registerLazySingleton<SkillRemoteDataSource>(
          () => SkillRemoteDataSourceImpl(sl()));


  // Repository
  sl.registerLazySingleton<SkillRepository>(() => SkillRepositoryImpl(sl()));



  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
