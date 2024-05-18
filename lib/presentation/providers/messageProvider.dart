import 'package:flutter/material.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/usecases/message/getChatContactsUsecase.dart';
import 'package:message_app/domain/usecases/message/getChatMessageUsecase.dart';
import 'package:message_app/domain/usecases/message/seenMessageUsecase.dart';
import 'package:message_app/domain/usecases/message/sendTextMessageUsecase.dart';

class MesssageProvider extends ChangeNotifier {
  SendTextMessageUsecase sendTextMessageUsecase;
  GetChatMessagesUsecase getChatMessagesUsecase;
  GetChatContactsUsecase getChatContactsUsecase;
  SeenMessageUsecase seenMessageUsecase;

  MesssageProvider({
    required this.sendTextMessageUsecase,
    required this.getChatMessagesUsecase,
    required this.getChatContactsUsecase,
    required this.seenMessageUsecase,
  });

  List<MessageEntity> messages = [];

  List<ChatContactEntity> chatContactList = [];

  Future<bool> sendTextMessage({
    required MessageEntity message,
    required UserModel sender,
    required UserModel receiver,
  }) {
    return sendTextMessageUsecase.call(
      message: message,
      sender: sender,
      receiver: receiver,
    );
  }

  getChatMessages({required String recieverid}) {
    getChatMessagesUsecase.call(recieverid: recieverid).listen((messageList) {
      this.messages = messageList;
      notifyListeners();
    });
  }

  void getChatContacts() {
    getChatContactsUsecase.call().listen((contactList) {
      this.chatContactList = contactList;
      notifyListeners();
    });
  }

  void seenMessage({required MessageEntity message}){
    seenMessageUsecase.call(message: message);
  }
}
