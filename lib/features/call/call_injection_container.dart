

import 'package:whatsapp_clone_app/features/call/data/remote/call_remote_data_source.dart';
import 'package:whatsapp_clone_app/features/call/data/remote/call_remote_data_source_impl.dart';
import 'package:whatsapp_clone_app/features/call/data/repository/call_repository_impl.dart';
import 'package:whatsapp_clone_app/features/call/domain/repository/call_repository.dart';
import 'package:whatsapp_clone_app/features/call/domain/usecases/get_call_channel_id_usecase.dart';
import 'package:whatsapp_clone_app/features/call/domain/usecases/get_user_calling_usecase.dart';
import 'package:whatsapp_clone_app/features/call/domain/usecases/make_call_usecase.dart';
import 'package:whatsapp_clone_app/features/call/domain/usecases/update_call_history_status_usecase.dart';
import 'package:whatsapp_clone_app/features/call/presentation/cubits/agora/agora_cubit.dart';
import 'package:whatsapp_clone_app/features/call/presentation/cubits/call/call_cubit.dart';
import 'package:whatsapp_clone_app/main_injection_container.dart';

import 'domain/usecases/end_call_usecase.dart';
import 'domain/usecases/get_my_call_history_usecase.dart';
import 'domain/usecases/save_call_history_usecase.dart';
import 'presentation/cubits/my_call_history/my_call_history_cubit.dart';

Future<void> callInjectionContainer() async {

  // * CUBITS INJECTION

  sl.registerFactory<CallCubit>(() => CallCubit(
      endCallUseCase: sl.call(),
      getUserCallingUseCase: sl.call(),
      makeCallUseCase: sl.call(), saveCallHistoryUseCase: sl.call(),
      updateCallHistoryStatusUseCase: sl.call()
  ));

  sl.registerFactory<MyCallHistoryCubit>(() => MyCallHistoryCubit(
      getMyCallHistoryUseCase: sl.call()
  ));

  sl.registerLazySingleton<AgoraCubit>(() => AgoraCubit());



  // * USE CASES INJECTION

  sl.registerLazySingleton<GetMyCallHistoryUseCase>(
          () => GetMyCallHistoryUseCase(repository: sl.call()));

  sl.registerLazySingleton<EndCallUseCase>(
          () => EndCallUseCase(repository: sl.call()));

  sl.registerLazySingleton<SaveCallHistoryUseCase>(
          () => SaveCallHistoryUseCase(repository: sl.call()));

  sl.registerLazySingleton<MakeCallUseCase>(
          () => MakeCallUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetUserCallingUseCase>(
          () => GetUserCallingUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCallChannelIdUseCase>(
          () => GetCallChannelIdUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateCallHistoryStatusUseCase>(
          () => UpdateCallHistoryStatusUseCase(repository: sl.call()));


  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<CallRepository>(
          () => CallRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<CallRemoteDataSource>(() => CallRemoteDataSourceImpl(
    fireStore: sl.call(),
  ));

}
