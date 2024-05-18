import 'dart:io';

import 'package:message_app/domain/entities/userEntity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login({required String email, required String password});

  Future<bool> register(UserEntity userEntity);
}

//************************************************************/
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<bool> register(UserEntity userEntity) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userEntity.email.toString(),
        password: userEntity.password.toString(),
      );

      if (userCredential.user?.uid != null) {
        firebaseFirestore
            .collection(FirebaseConst.users)
            .doc(userCredential.user?.uid)
            .set(UserModel(
                uuid: userCredential.user!.uid,
                name: userEntity.name,
                email: userEntity.email,
                phone: userEntity.phone,
                friends: []).toJson());
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      ('login : authRemoteDataSourceImpl : ${e}');
      return false;
    }
  }

  @override
  Future<bool> login({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );

      if (userCredential.user?.uid != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('login : authRemoteDataSourceImpl : ${e}');
      return false;
    }
  }

  Future<String> storeFile({
    required String path,
    required String id,
    required File file,
  }) async {
    try {
      final ref = firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }
}
