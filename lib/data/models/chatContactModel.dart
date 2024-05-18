import 'package:message_app/domain/entities/chatContactEntity.dart';

class ChatContactModel extends ChatContactEntity {
  final String? name;
  final String? profilePic;
  final String? contactId;
  final DateTime? timeSent;
  final String? lastMessage;
  ChatContactModel({
    this.name,
    this.profilePic,
    this.contactId,
    this.timeSent,
    this.lastMessage,
  }) : super(  
    name: name,
    profilePic: profilePic,
    contactId: contactId,
    timeSent: timeSent,
    lastMessage: lastMessage
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent?.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }
}
