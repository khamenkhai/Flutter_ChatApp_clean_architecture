import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:message_app/data/data_source/authRemoteDataSource.dart';
import 'package:message_app/data/data_source/messageRemoteDataSource.dart';
import 'package:message_app/data/data_source/userRemoteDatasource.dart';
import 'package:message_app/data/repositories/authRepositoryImpl.dart';
import 'package:message_app/data/repositories/messageRepositoryImpl.dart';
import 'package:message_app/data/repositories/userRepositoryImpl.dart';
import 'package:message_app/domain/repositories/authRepository.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';
import 'package:message_app/domain/repositories/userRepository.dart';
import 'package:message_app/domain/usecases/auth/loginUsecase.dart';
import 'package:message_app/domain/usecases/auth/registerUsecase.dart';
import 'package:message_app/domain/usecases/message/getChatContactsUsecase.dart';
import 'package:message_app/domain/usecases/message/getChatMessageUsecase.dart';
import 'package:message_app/domain/usecases/message/seenMessageUsecase.dart';
import 'package:message_app/domain/usecases/message/sendTextMessageUsecase.dart';
import 'package:message_app/domain/usecases/user/getAllFriendsUsecase.dart';
import 'package:message_app/domain/usecases/user/getSingleUserUsecase.dart';
import 'package:message_app/presentation/providers/authProvider.dart' as ap;
import 'package:message_app/presentation/providers/messageProvider.dart';
import 'package:message_app/presentation/providers/userProvider.dart';

final getIt = GetIt.instance;

void init(){

  //provider
  getIt.registerFactory(() => ap.AuthProvider(loginUsecase: getIt.call(), registerUsecase: getIt.call()));
  getIt.registerFactory(() => UserProvider(getSingleUserUsecase: getIt.call(), getAllFriendsUsecase: getIt.call()));
  getIt.registerFactory(() => MesssageProvider(sendTextMessageUsecase: getIt.call(), getChatMessagesUsecase: getIt.call(),getChatContactsUsecase: getIt.call(),seenMessageUsecase: getIt.call()));

  ///usecases
  getIt.registerLazySingleton(() => LoginUsecase(authRepository: getIt.call()));
  getIt.registerLazySingleton(() => RegisterUsecase(authRepository: getIt.call()));

  getIt.registerLazySingleton(() => GetSingleUserUsecase(userRepository: getIt.call()));
  getIt.registerLazySingleton(() => GetAllFriendsUsecase(userRepository: getIt.call()));

  getIt.registerLazySingleton(() => SendTextMessageUsecase(messageRepository: getIt.call()));
  getIt.registerLazySingleton(() => GetChatMessagesUsecase (messageRepository: getIt.call()));
  getIt.registerLazySingleton(() => GetChatContactsUsecase (messageRepository: getIt.call()));
  getIt.registerLazySingleton(() => SeenMessageUsecase (messageRepository: getIt.call()));


  ///repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: getIt.call()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userRemoteDataSource: getIt.call()));
  getIt.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(messageRemoteDataSource: getIt.call()));

  ///remote datasource
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: getIt.call(),firebaseFirestore: getIt.call(),firebaseStorage: getIt.call()));
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(firebaseAuth: getIt.call(),firebaseFirestore: getIt.call(),firebaseStorage: getIt.call()));
  getIt.registerLazySingleton<MessageRemoteDataSource>(() => MessageRemoteDataSourceImpl(firebaseAuth: getIt.call(),firestore: getIt.call(),firebaseStorage: getIt.call()));


  ///firebase
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  getIt.registerLazySingleton(() => firebaseFirestore);
  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseStorage);

}