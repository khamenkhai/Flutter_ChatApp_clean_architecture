// ignore_for_file: unnecessary_cast
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/userEntity.dart';

/**
 * user remote datasource class
 */
abstract class UserRemoteDataSource {
  Stream<UserEntity> getSingleUser(String userId);

  Stream<List<UserEntity>> getAllFriends(List<String> userIdList);
}


/********************************************************************/

/**
 * user remote datasource implementation class
 */
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Stream<List<UserEntity>> getAllFriends(List<String> userIdList) {
    return firebaseFirestore
        .collection(FirebaseConst.users)
        .snapshots()
        .map((event) {
      return event.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<UserEntity> getSingleUser(String userId) {
    return firebaseFirestore
        .collection(FirebaseConst.users)
        .doc(userId)
        .snapshots()
        .map((event) =>
            UserModel.fromJson(event.data() as Map<String, dynamic>));
  }
}
