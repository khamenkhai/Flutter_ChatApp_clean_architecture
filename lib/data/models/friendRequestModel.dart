import 'package:message_app/domain/entities/friendRequestEntity.dart';

class FriendRequestModel extends FriendRequestEntity{
  String? id;
  String? senderId;
  String? receiverId;
  String? status;
  DateTime? timeSent;

  FriendRequestModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.status,
    this.timeSent
  }) : super(  
    id: id,
    senderId: senderId,
    receiverId: receiverId,
    status: status,
    timeSent: timeSent
  );


  factory FriendRequestModel.fromJson(Map<String,dynamic> json){
    return FriendRequestModel(
      id: json["id"] ?? "",
      senderId: json["senderId"] ?? "",
      receiverId: json["receiverId"] ?? "",
      status: json["status"] ?? "",
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent']),
    );
  }


  toJson(){
    return {
      "id" : this.id,
      "senderId" : this.senderId,
      "receiverId" : this.receiverId,
      "status" : this.status,
      "timeSent" : this.timeSent?.microsecondsSinceEpoch
    };
  }
}
