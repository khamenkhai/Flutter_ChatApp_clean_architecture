import 'package:message_app/domain/entities/userEntity.dart';

class UserModel extends UserEntity{
  String? uuid;
  String? name;
  String? email;
  String? bio;
  String? phone;
  String? profileImage;
  String? coverImage;
  List<String>? friends;
  DateTime? lastActive;
  bool? isOnline;

  UserModel({
    this.uuid,
    this.name,
    this.email,
    this.bio,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.friends,
    this.lastActive,
    this.isOnline
  }) : super(  
    uuid: uuid,
    name: name,
    email: email,
    bio: bio,
    phone: phone,
    profileImage: profileImage,
    coverImage: coverImage,
    friends: friends
  );

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      uuid: json["uuid"],
      name: json["name"],
      email: json["email"],
      bio: json["bio"],
      phone: json["phone"],
      profileImage: json["profileImage"],
      coverImage: json["coverImage"],
      friends: List<String>.from(json["friends"] ?? []),
      isOnline: json['isOnline'] ?? null,
      lastActive:json["lastActive"] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastActive']) : null
    );
  }


  factory UserModel.fromEntity(UserEntity userEntity){
    return UserModel(
      uuid: userEntity.uuid,
      name:userEntity.name,
      bio: userEntity.bio,
      coverImage: userEntity.coverImage,
      email: userEntity.email,
      friends: userEntity.friends,
      isOnline: userEntity.isOnline,
      lastActive: userEntity.lastActive,
      phone: userEntity.phone,
      profileImage: userEntity.profileImage
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid ?? "",
      "name": name ?? "",
      "email": email ?? "",
      "bio": bio ?? "",
      "phone": phone ?? "",
      "profileImage": profileImage ?? "",
      "coverImage": coverImage ?? "",
      "friends": friends ?? [],
      "isOnline": isOnline,
      "lastActive": lastActive?.microsecondsSinceEpoch
    };
  }

  
}