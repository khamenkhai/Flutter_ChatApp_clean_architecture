import 'package:message_app/data/data_source/authRemoteDataSource.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/authRepository.dart';

class AuthRepositoryImpl implements AuthRepository{
  
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<bool> login({required String email, required String password})=>authRemoteDataSource.login(email: email,password: password);

  @override
  Future<bool> register(UserEntity userEntity) => authRemoteDataSource.register(userEntity);
  
  

}