import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class SendTextMessageUsecase{
  final MessageRepository messageRepository;

  SendTextMessageUsecase({required this.messageRepository});

  Future<bool> call({required MessageEntity message, required UserModel sender,required UserModel receiver})async{
    //print("message : ${message.toString()}");
    return messageRepository.sendTextMessage(message: message, sender: sender, receiver: receiver);
  }
}