class UserEntity {
  String? uuid;
  String? name;
  String? email;
  String? password;
  String? bio;
  String? phone;
  String? profileImage;
  String? coverImage;
  List<String>? friends;
  DateTime? lastActive;
  bool? isOnline;

  UserEntity({
    this.uuid,
    this.name,
    this.email,
    this.password,
    this.bio,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.friends,
    this.lastActive,
    this.isOnline
  });
}
