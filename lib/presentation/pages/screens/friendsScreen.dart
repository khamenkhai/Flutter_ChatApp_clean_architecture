import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_app/common/commonWidgets.dart';
import 'package:message_app/common/const.dart';
import 'package:message_app/common/util.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/presentation/pages/screens/chatScreen.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Friends".toUpperCase(),
          style: TextStyle(letterSpacing: 5),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                height: 0,
              ),
            ),
            SizedBox(height: 15),

            ///friend request row
            Row(
              children: [
                Text(
                  "Friend requests",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                Text(
                  "35",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            _friendList(),

            // Expanded(
            //   child: ListView.separated(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 15,
            //     separatorBuilder: (context, index) {
            //       return SizedBox(height: 15);
            //     },
            //     itemBuilder: (context, index) {
            //       return _friendRequestCardWidget(context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Container _friendRequestCardWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 39,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "User name",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("5w"),
                  ],
                ),
                Text(
                  "11 mutual friends",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    ///confirm button
                    Expanded(
                      child: Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Confirm"),
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    ///delete button
                    Expanded(
                      child: Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Consumer<UserProvider> _friendList() {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return value.userFriends != null
            ? Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: value.userFriends!.length,
                  padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 7);
                  },
                  itemBuilder: (context, index) {
                    UserModel user = value.userFriends![index];
                    return GestureDetector(
                      onTap: () {
                        redirectTo(
                            page: ChatScreen(
                              receiverName: user.name.toString(),
                              receiverProfile: user.profileImage.toString(),
                              recieverUuid: user.uuid.toString(),
                            ),
                            context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              user.profileImage.toString() == "" ||
                                      user.profileImage == "null"
                                  ? profileLink
                                  : user.profileImage.toString(),
                            ),
                          ),
                          title: Text("${user.name}"),
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
    );
  }
}
