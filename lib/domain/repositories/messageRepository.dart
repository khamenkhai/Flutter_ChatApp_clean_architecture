import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/entities/userEntity.dart';

abstract class MessageRepository{

  Future<bool> sendTextMessage({required MessageEntity message, required UserEntity sender,required UserEntity receiver});

  Future<bool> sendImageMessage({required MessageEntity message, required UserEntity sender,required UserEntity receiver});

  Stream<List<MessageEntity>> getChatMessages({required String recieverid});

  Stream<List<ChatContactEntity>> getChatContacts();

  void seenMessage({required MessageEntity message});
}