class FriendRequestEntity {
  String? id;
  String? senderId;
  String? receiverId;
  String? status;
  DateTime? timeSent;

  FriendRequestEntity({
    this.id,
    this.senderId,
    this.receiverId,
    this.status,
    this.timeSent
  });
}
