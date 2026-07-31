import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/crop_incident/data/datasources/incident_remote_data_source.dart';
import '../../features/crop_incident/data/repositories/incident_repository_impl.dart';
import '../../features/crop_incident/domain/repositories/incident_repository.dart';
import '../../features/crop_incident/domain/usecases/create_incident_usecase.dart';
import '../../features/crop_incident/domain/usecases/delete_incident_usecase.dart';
import '../../features/crop_incident/domain/usecases/get_incidents_usecase.dart';
import '../../features/crop_incident/domain/usecases/update_incident_usecase.dart';
import '../../features/crop_incident/presentation/bloc/incident_bloc.dart';

import '../../features/settings_profile/data/datasources/settings_local_data_source.dart';
import '../../features/settings_profile/presentation/cubit/settings_cubit.dart';

import '../../features/weather_calendar/data/datasources/advisory_remote_data_source.dart';
import '../../features/weather_calendar/data/repositories/advisory_repository_impl.dart';
import '../../features/weather_calendar/domain/repositories/advisory_repository.dart';
import '../../features/weather_calendar/domain/usecases/get_advisories_usecase.dart';
import '../../features/weather_calendar/presentation/cubit/advisory_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({
  FirebaseAuth? firebaseAuth,
  FirebaseFirestore? firestore,
}) async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Settings Profile Feature
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(localDataSource: sl()));

  // Auth Feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      signOutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

  // Crop Incident Feature
  sl.registerLazySingleton<IncidentRemoteDataSource>(
    () => IncidentRemoteDataSourceImpl(firestore: firestore),
  );
  sl.registerLazySingleton<IncidentRepository>(
    () => IncidentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetIncidentsUseCase(sl()));
  sl.registerLazySingleton(() => CreateIncidentUseCase(sl()));
  sl.registerLazySingleton(() => UpdateIncidentUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIncidentUseCase(sl()));
  sl.registerFactory<IncidentBloc>(
    () => IncidentBloc(
      getIncidentsUseCase: sl(),
      createIncidentUseCase: sl(),
      updateIncidentUseCase: sl(),
      deleteIncidentUseCase: sl(),
    ),
  );

  // Weather Calendar Advisory Feature
  sl.registerLazySingleton<AdvisoryRemoteDataSource>(
    () => AdvisoryRemoteDataSourceImpl(firestore: firestore),
  );
  sl.registerLazySingleton<AdvisoryRepository>(
    () => AdvisoryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetAdvisoriesUseCase(sl()));
  sl.registerFactory<AdvisoryCubit>(
    () => AdvisoryCubit(getAdvisoriesUseCase: sl()),
  );
}
