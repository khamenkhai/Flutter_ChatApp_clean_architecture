import 'package:message_app/data/data_source/messageRemoteDataSource.dart';
import 'package:message_app/data/models/messageModel.dart';
import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class MessageRepositoryImpl implements MessageRepository{
  
  MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});



  @override
  Future<bool> sendTextMessage({required MessageEntity message,required UserEntity sender,required UserEntity receiver}) async{
    return messageRemoteDataSource.sendTextMessage(message: MessageModel.fromEntity(message), sender: sender, receiver: receiver);
  }
  
  @override
  Stream<List<MessageEntity>> getChatMessages({required String recieverid}) {
    return messageRemoteDataSource.getChatMessages(recieverid: recieverid);
  }

  @override
  Stream<List<ChatContactEntity>> getChatContacts() {
    return messageRemoteDataSource.getChatContacts();
  }

  @override
  Future<bool> sendImageMessage({required MessageEntity message, required UserEntity sender, required UserEntity receiver}) {
    return messageRemoteDataSource.sendImageMessage(message: MessageModel.fromEntity(message), sender: sender, receiver: receiver);
  }
  
  @override
  void seenMessage({required MessageEntity message}) {
    messageRemoteDataSource.seenMessage(message: message);
  }
  
}