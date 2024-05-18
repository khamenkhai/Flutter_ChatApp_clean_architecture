import 'package:message_app/domain/entities/messageEntity.dart';

class MessageModel extends MessageEntity {
  String? senderId;
  String? recieverid;
  String? text;
  MessageType? type;
  DateTime? timeSent;
  String? messageId;
  String? imageLink;
  bool? isSeen;

  MessageModel({
    this.senderId,
    this.recieverid,
    this.text,
    this.type,
    this.timeSent,
    this.messageId,
    this.isSeen,
    this.imageLink,
  }) : super(
          senderId: senderId,
          recieverid: recieverid,
          text: text,
          type: type,
          timeSent: timeSent,
          messageId: messageId,
          isSeen: isSeen,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      recieverid: json['recieverid'],
      text: json['text'],
      type: json['type'] != null ? MessageType.values[json['type']] : null,
      timeSent: json['timeSent'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timeSent'])
          : null,
      messageId: json['messageId'],
      isSeen: json['isSeen'],
      imageLink : json['imageLink'] ?? "",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'type': type?.index,
      'timeSent': timeSent?.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'imageLink': imageLink
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      recieverid: entity.recieverid,
      text: entity.text,
      type: entity.type,
      timeSent: entity.timeSent,
      messageId: entity.messageId,
      isSeen: entity.isSeen,
      //image: entity.image
    );
  }
}
