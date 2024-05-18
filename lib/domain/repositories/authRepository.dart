import 'package:message_app/domain/entities/userEntity.dart';

abstract class AuthRepository{

  Future<bool> login({required String email,required String password});
  
  Future<bool> register(UserEntity userEntity);
}