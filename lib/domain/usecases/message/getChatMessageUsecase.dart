import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class GetChatMessagesUsecase{
  final MessageRepository messageRepository;

  GetChatMessagesUsecase({required this.messageRepository});

  Stream<List<MessageEntity>> call({required String recieverid}){

    return messageRepository.getChatMessages(recieverid: recieverid);
  }
}