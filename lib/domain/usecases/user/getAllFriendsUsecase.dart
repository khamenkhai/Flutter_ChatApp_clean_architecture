import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/userRepository.dart';

class GetAllFriendsUsecase{
  final UserRepository userRepository;

  GetAllFriendsUsecase({required this.userRepository});

  Stream<List<UserEntity>> call(List<String> userIdList){
    return userRepository.getAllFriends(userIdList);
  }
}