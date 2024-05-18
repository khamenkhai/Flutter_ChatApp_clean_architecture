import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/usecases/auth/loginUsecase.dart';
import 'package:message_app/domain/usecases/auth/registerUsecase.dart';

class AuthProvider extends ChangeNotifier{
  LoginUsecase loginUsecase;
  RegisterUsecase registerUsecase;

  AuthProvider({required this.loginUsecase,required this.registerUsecase});

  bool isLoggedIn = false;

  bool loading = false;

  User? get currentUser => FirebaseAuth.instance.currentUser;


  Future<bool> loginUser({required String email,required String password})async{
    return loginUsecase.call(email: email,password: password);
  }

  Future<bool> register(UserEntity userEntity)async{
    loading = true;
    notifyListeners();
    return registerUsecase.call(userEntity).then((value){
      loading = false;
      notifyListeners();
      return value;
    });
  }

  
}