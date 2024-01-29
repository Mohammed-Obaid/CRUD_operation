


import 'package:crud_operations/app/data/user/api/user_api.dart';
import 'package:crud_operations/app/data/user/db/user_db.dart';
import 'package:crud_operations/app/data/user/repository/user_repository.dart';
import 'package:crud_operations/app/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt =GetIt.instance;


Future<void> init() async{

  // registerLazySingleton is a method used in dependency injection (DI) 
  //to register a class as a singleton,
  // but with a key difference: the instance is only created when it's first requested.
  
  //Dio
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  // User api
  getIt.registerLazySingleton<UserApi>(
      () => UserApi(dioClient: getIt<DioClient>()));
  // User DB    
  getIt.registerLazySingleton<UserDB>(
      () => UserDB());


  // User repository using Api
  // getIt.registerLazySingleton<UserRepository>(
  //   () => UserRepository(dataSource: getIt<UserApi>()),
  // );

  // User repository using DB
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(dataSource: getIt<UserDB>()),
  );


  //UserController
  // getIt.registerFactory(
  //   () => UserController(userRepository: getIt<UserRepository>()),
  // );


}