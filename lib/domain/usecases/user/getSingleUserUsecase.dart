import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/userRepository.dart';

class GetSingleUserUsecase{
  final UserRepository userRepository;

  GetSingleUserUsecase({required this.userRepository});

  Stream<UserEntity> call(String userId){
    return userRepository.getSingleUser(userId);
  }
}