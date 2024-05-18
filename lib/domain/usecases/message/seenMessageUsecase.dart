import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class SeenMessageUsecase{
  final MessageRepository messageRepository;

  SeenMessageUsecase({required this.messageRepository});

  void call({required MessageEntity message})async{
    return messageRepository.seenMessage(message: message);
  }
}