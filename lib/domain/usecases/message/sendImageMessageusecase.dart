import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/repositories/messageRepository.dart';

class SendImageMessageUsecase {
  final MessageRepository messageRepository;

  SendImageMessageUsecase({required this.messageRepository});

  Future<bool> call({
    required MessageEntity message,
    required UserModel sender,
    required UserModel receiver,
  }) async {
    return messageRepository.sendImageMessage(
      message: message,
      sender: sender,
      receiver: receiver,
    );
  }
}
