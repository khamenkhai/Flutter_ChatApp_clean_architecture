class ChatContactEntity {
  final String? name;
  final String? profilePic;
  final String? contactId;
  final DateTime? timeSent;
  final String? lastMessage;
  ChatContactEntity({
     this.name,
     this.profilePic,
     this.contactId,
     this.timeSent,
     this.lastMessage,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'profilePic': profilePic,
  //     'contactId': contactId,
  //     'timeSent': timeSent.millisecondsSinceEpoch,
  //     'lastMessage': lastMessage,
  //   };
  // }

  // factory ChatContactEntity.fromMap(Map<String, dynamic> map) {
  //   return ChatContactEntity(
  //     name: map['name'] ?? '',
  //     profilePic: map['profilePic'] ?? '',
  //     contactId: map['contactId'] ?? '',
  //     timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
  //     lastMessage: map['lastMessage'] ?? '',
  //   );
  // }
}