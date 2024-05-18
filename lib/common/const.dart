import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConst{
  static const String users = "MAusers";
  static const String messages = "MAmessages";
  static const String chats = "MAchats";

  static String? get currentUserId => FirebaseAuth.instance.currentUser?.uid.toString();
}

final String profileLink= "https://banner2.cleanpng.com/20180329/zue/kisspng-computer-icons-user-profile-person-5abd85306ff7f7.0592226715223698404586.jpg";