// ignore_for_file: unnecessary_cast
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/data/models/chatContactModel.dart';
import 'package:message_app/data/models/messageModel.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:uuid/uuid.dart';

/**
 * user remote datasource class
 */
abstract class MessageRemoteDataSource {
  Future<bool> sendTextMessage({
    required MessageModel message,
    required UserEntity sender,
    required UserEntity receiver,
  });

  Future<bool> sendImageMessage({
    required MessageModel message,
    required UserEntity sender,
    required UserEntity receiver,
  });

  Stream<List<MessageEntity>> getChatMessages({required String recieverid});

  Stream<List<ChatContactEntity>> getChatContacts();

  seenMessage({required MessageEntity message});
}

/********************************************************************/

/**
 * user remote datasource implementation class
 */
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  MessageRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<bool> sendTextMessage({
    required MessageModel message,
    required UserEntity sender,
    required UserEntity receiver,
  }) async {
    try {
      String messageId = Uuid().v4();

      message.messageId = messageId;

      // print("sender name : ${sender.name}");
      // print('receiver name : ${receiver.name}');

      _saveMessageToChatContactCollection(
        message: message,
        receiver: UserModel.fromEntity(receiver),
        // message: MessageModel.fromEntity(message),
        // receiver: UserModel.fromEntity(receiver),
        sender: UserModel.fromEntity(sender),
      );

      _saveMessageToMessageCollection(MessageModel.fromEntity(message));

      return true;
    } catch (e) {
      return false;
    }
  }

  void _saveMessageToMessageCollection(MessageModel message) async {
    try {
      await firestore
          .collection(FirebaseConst.users)
          .doc(FirebaseConst.currentUserId)
          .collection(FirebaseConst.chats)
          .doc(message.recieverid)
          .collection(FirebaseConst.messages)
          .doc(message.messageId)
          .set(
            message.toJson(),
          );

      await firestore
          .collection(FirebaseConst.users)
          .doc(message.recieverid)
          .collection(FirebaseConst.chats)
          .doc(FirebaseConst.currentUserId)
          .collection(FirebaseConst.messages)
          .doc(message.messageId)
          .set(
            message.toJson(),
          );
    } on FirebaseException catch (e) {
      print("__saveMessageToMessageCollection : ${e}");
    }
  }

  void _saveMessageToChatContactCollection(
      {required MessageModel message,
      required UserModel sender,
      required UserModel receiver}) async {
    try {
      ChatContactModel receiverData = ChatContactModel(
        lastMessage: message.text,
        contactId: receiver.uuid,
        name: receiver.name,
        profilePic: receiver.profileImage,
        timeSent: message.timeSent,
      );

      await firestore
          .collection(FirebaseConst.users)
          .doc(FirebaseConst.currentUserId)
          .collection(FirebaseConst.chats)
          .doc(message.recieverid)
          .set(
            receiverData.toJson(),
          );

      ChatContactModel senderData = ChatContactModel(
        lastMessage: message.text,
        contactId: sender.uuid,
        name: sender.name,
        profilePic: sender.profileImage,
        timeSent: message.timeSent,
      );

      await firestore
          .collection(FirebaseConst.users)
          .doc(message.recieverid)
          .collection(FirebaseConst.chats)
          .doc(FirebaseConst.currentUserId)
          .set(
            senderData.toJson(),
          );
    } on FirebaseException catch (e) {
      print("__saveMessageToMessageCollection : ${e}");
    }
  }

  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v4();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Stream<List<MessageEntity>> getChatMessages({required String recieverid}) {
    return firestore
        .collection(FirebaseConst.users)
        .doc(FirebaseConst.currentUserId)
        .collection(FirebaseConst.chats)
        .doc(recieverid)
        .collection(FirebaseConst.messages)
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        // print(
        //     "${MessageModel.fromJson(e.data() as Map<String, dynamic>).text}");
        return MessageModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<List<ChatContactEntity>> getChatContacts() {
    return firestore
        .collection(FirebaseConst.users)
        .doc(FirebaseConst.currentUserId)
        .collection(FirebaseConst.chats)
        .snapshots()
        .map(
          (event) => event.docs.map((e) {
            return ChatContactModel.fromMap(e.data());
          }).toList(),
        );
  }

  @override
  seenMessage({required MessageEntity message}) {
    // await firestore
    //     .collection('WAusers')
    //     .doc(auth.currentUser!.uid)
    //     .collection('chats')
    //     .doc(recieverUserId)
    //     .collection('messages')
    //     .doc(messageId)
    //     .update({'isSeen': true});

    firestore
        .collection(FirebaseConst.users)
        .doc(message.senderId)
        .collection(FirebaseConst.chats)
        .doc(message.recieverid)
        .collection(FirebaseConst.messages)
        .doc(message.messageId)
        .update(
      {"isSeen": true},
    );

    // await firestore
    //     .collection('WAusers')
    //     .doc(recieverUserId)
    //     .collection('chats')
    //     .doc(auth.currentUser!.uid)
    //     .collection('messages')
    //     .doc(messageId)
    //     .update({'isSeen': true});
    firestore
        .collection(FirebaseConst.users)
        .doc(message.recieverid)
        .collection(FirebaseConst.chats)
        .doc(message.senderId)
        .collection(FirebaseConst.messages)
        .doc(message.messageId)
        .update(
      {"isSeen": true},
    );

    print("message already seen!");
  }

  @override
  Future<bool> sendImageMessage({
    required MessageModel message,
    required UserEntity sender,
    required UserEntity receiver,
  }) {
    // TODO: implement sendImageMessage
    throw UnimplementedError();
  }
}
