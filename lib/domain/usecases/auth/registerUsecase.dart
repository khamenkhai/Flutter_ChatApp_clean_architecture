import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/authRepository.dart';

class RegisterUsecase{
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<bool> call(UserEntity userEntity){
    return authRepository.register(userEntity);
  }
}