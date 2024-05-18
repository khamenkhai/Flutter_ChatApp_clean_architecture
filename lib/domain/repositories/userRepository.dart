import 'package:message_app/domain/entities/userEntity.dart';

abstract class UserRepository{

  Stream<UserEntity> getSingleUser(String userId);

  Stream<List<UserEntity>> getAllFriends(List<String> userIdList);

}