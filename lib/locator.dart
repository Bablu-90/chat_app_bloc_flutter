



import 'package:chat_app_bloc_flutter/services/auth_service.dart';
import 'package:chat_app_bloc_flutter/services/chat_service.dart';
import 'package:chat_app_bloc_flutter/services/repository_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RepositoryService());
  locator.registerLazySingleton(() => ChatService());

}