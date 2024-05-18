import 'package:flutter/material.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/usecases/user/getAllFriendsUsecase.dart';
import 'package:message_app/domain/usecases/user/getSingleUserUsecase.dart';

class UserProvider extends ChangeNotifier {
  GetSingleUserUsecase getSingleUserUsecase;
  GetAllFriendsUsecase getAllFriendsUsecase;

  UserProvider({
    required this.getSingleUserUsecase,
    required this.getAllFriendsUsecase,
  });

  bool isLoggedIn = false;

  UserModel? currentUser;

  List<UserModel>? userFriends;

  Stream<UserEntity> getSingleUser({required String userId}) {
    return getSingleUserUsecase.call(userId);
  }

  void getCurrentUser() {
    try {
      getSingleUserUsecase
          .call(FirebaseConst.currentUserId.toString())
          .listen((event) {
        currentUser = UserModel.fromEntity(event);
        notifyListeners();
      });

      print('current user data : ${currentUser}');
    } catch (e) {
      print("getCurrentUser : ${e}");
    }
  }

  getAllfriends({required List<String> userIdList}) {
    getAllFriendsUsecase.call(userIdList).listen((event) {
      this.userFriends = event.map((e) => UserModel.fromEntity(e)).toList();
      notifyListeners();
    });
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
