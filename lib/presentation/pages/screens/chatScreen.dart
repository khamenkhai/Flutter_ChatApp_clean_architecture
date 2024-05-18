import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/domain/entities/messageEntity.dart';
import 'package:message_app/presentation/providers/messageProvider.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.receiverName,
    required this.receiverProfile,
    required this.recieverUuid,
  });
  final String receiverName;
  final String receiverProfile;
  final String recieverUuid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  ScrollController messageScrollController = ScrollController();

  @override
  void initState() {
    Provider.of<MesssageProvider>(context, listen: false).getChatMessages(
      recieverid: widget.recieverUuid.toString(),
    );
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    messageScrollController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  File? _imageFile;

  Future<void> pickImage() async {
    // // Request storage permission if needed (Android only)
    // if (Platform.isAndroid) {
    //   final PermissionStatus storageStatus = await Permission.storage.request();
    //   if (storageStatus != PermissionStatus.granted) {
    //     return; // User denied permission
    //   }
    // }

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                widget.receiverProfile.toString() == "" ||
                        widget.receiverProfile == "null"
                    ? profileLink
                    : widget.receiverProfile.toString(),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.receiverName}",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.2,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            UserModel currentUser = userProvider.currentUser!;
            return Column(
              children: [
                Expanded(
                  child: Consumer<MesssageProvider>(
                    builder: (context, messageProvider, child) {
                      if (messageProvider.messages.isNotEmpty) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          messageScrollController.jumpTo(
                            messageScrollController.position.maxScrollExtent,
                          );
                        });
                      }

                      return messageProvider.messages.isNotEmpty ||
                              messageProvider.messages.length > 0
                          ? SingleChildScrollView(
                              controller: messageScrollController,
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  ...messageProvider.messages.map(
                                    (e) {
                                      if (e.isSeen == false &&
                                          e.recieverid ==
                                              FirebaseConst.currentUserId) {
                                        Provider.of<MesssageProvider>(context,
                                                listen: false)
                                            .seenMessage(message: e);

                                      }

                                      return e.senderId == currentUser.uuid
                                          ? __myMessageBox(
                                              screenSize: screenSize,
                                              message: e,
                                              user: currentUser,
                                            )
                                          : _otherUserMessageBox(
                                              screenSize: screenSize,
                                              message: e,
                                            );
                                    },
                                  ).toList()
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
                _bottomChatField(context, currentUser, image: _imageFile)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bottomChatField(
    BuildContext context,
    UserModel currentUser, {
    File? image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_emotions),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message..",
                            contentPadding: EdgeInsets.only(bottom: 12),
                          ),
                        ),
                      ),

                      ///image selection button
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Icon(Icons.image),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  bool sendMessageStatus = await Provider.of<MesssageProvider>(
                    context,
                    listen: false,
                  ).sendTextMessage(
                    message: MessageEntity(
                        text: messageController.text,
                        isSeen: false,
                        recieverid: widget.recieverUuid,
                        type: MessageType.text,
                        senderId: FirebaseConst.currentUserId,
                        timeSent: DateTime.now()),
                    receiver: UserModel(
                        name: widget.receiverName, uuid: widget.recieverUuid),
                    sender: currentUser,
                  );

                  if (sendMessageStatus) {
                    setState(() {
                      messageController.clear();
                    });
                  }
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _otherUserMessageBox({
    required Size screenSize,
    required MessageEntity message,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
                widget.receiverProfile == "null" || widget.receiverProfile == ""
                    ? NetworkImage(profileLink)
                    : NetworkImage(
                        widget.receiverProfile.toString(),
                      ),
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.only(top: 7),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              minWidth: 200,
              minHeight: 45,
              maxWidth: screenSize.width / 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${timeago.format(DateTime.parse(message.timeSent.toString()))}",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row __myMessageBox({
    required Size screenSize,
    required MessageEntity message,
    required UserModel user,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          //height: 200,
          margin: EdgeInsets.only(bottom: 10, top: 5),
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(
            minWidth: 200,
            minHeight: 45,
            maxWidth: screenSize.width / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.text.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${timeago.format(DateTime.parse(message.timeSent.toString()))}",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(width: 7),
                  Icon(
                    message.isSeen! ? Icons.done_all : Icons.check,
                    size: 15,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundImage: user.profileImage == null || user.profileImage == ""
              ? NetworkImage(profileLink)
              : NetworkImage(user.profileImage.toString()),
          // child: user.profileImage == null || user.profileImage == ""
          //     ? Icon(Icons.person)
          //     : Container(),
        ),
      ],
    );
  }
}
