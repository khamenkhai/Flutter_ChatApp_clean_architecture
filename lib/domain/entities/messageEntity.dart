import 'dart:io';

class MessageEntity {
  String? senderId;
  String? recieverid;
  String? text;
  MessageType? type;
  DateTime? timeSent;
  String? messageId;
  File? image;
  bool? isSeen;

  MessageEntity({
    this.senderId,
    this.recieverid,
    this.text,
    this.type,
    this.timeSent,
    this.messageId,
    this.isSeen,
    this.image,
  });
}

enum MessageType {
  text,
  image;

  String toJson() => name;

  factory MessageType.fromJson(String json) => values.byName(json);
}
