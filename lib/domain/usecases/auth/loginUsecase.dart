import 'package:message_app/domain/repositories/authRepository.dart';

class LoginUsecase{
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<bool> call({required String email,required String password}){
    return authRepository.login(email: email,password: password);
  }
}