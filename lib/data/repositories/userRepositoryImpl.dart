import 'package:message_app/data/data_source/userRemoteDatasource.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/userRepository.dart';

class UserRepositoryImpl implements UserRepository{
  
  UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Stream<List<UserEntity>> getAllFriends(List<String> userIdList) {
    return userRemoteDataSource.getAllFriends(userIdList);
  }

  @override
  Stream<UserEntity> getSingleUser(String userId) {
    return userRemoteDataSource.getSingleUser(userId);
  }
  
}