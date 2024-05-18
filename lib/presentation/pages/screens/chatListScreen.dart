import 'package:flutter/material.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/common/util.dart';
import 'package:message_app/domain/entities/chatContactEntity.dart';
import 'package:message_app/presentation/pages/screens/chatScreen.dart';
import 'package:message_app/presentation/providers/messageProvider.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:message_app/presentation/widgets/loadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getAllfriends(
      userIdList: [],
    );
    Provider.of<MesssageProvider>(context, listen: false).getChatContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHATS".toUpperCase(),
          style: TextStyle(letterSpacing: 5),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              onTap: () {},
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search ...",
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 15,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Consumer<MesssageProvider>(
            builder: (context, value, child) {
              return value.chatContactList.length > 0
                  ? Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: value.chatContactList.length,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 7);
                        },
                        itemBuilder: (context, index) {
                          ChatContactEntity user = value.chatContactList[index];
                          return GestureDetector(
                            onTap: () {
                              redirectTo(
                                page: ChatScreen(
                                  receiverName: user.name.toString(),
                                  receiverProfile: user.profilePic.toString(),
                                  recieverUuid: user.contactId.toString(),
                                ),
                                context: context,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                //color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    user.profilePic.toString() == ""
                                        ? profileLink
                                        : user.profilePic.toString(),
                                  ),
                                ),
                                title: Text("${user.name}"),
                                subtitle: Text("${user.lastMessage}"),
                                trailing: Text(
                                    "${timeago.format(DateTime.parse(user.timeSent.toString()))}"),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: loadingWidget(),
                    );
            },
          ),
        ],
      ),
    );
  }
}
