import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class GetChatContactsUsecase{
  final MessageRepository messageRepository;

  GetChatContactsUsecase({required this.messageRepository});

  Stream<List<ChatContactEntity>> call(){
    return messageRepository.getChatContacts();
  }
}