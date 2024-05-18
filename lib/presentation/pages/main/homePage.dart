import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:message_app/presentation/pages/screens/chatListScreen.dart';
import 'package:message_app/presentation/pages/screens/friendsScreen.dart';
import 'package:message_app/presentation/pages/screens/profileScreen.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int currentIndex = 0;

  List<Widget> mainScreens = [
    ChatListScreen(),
    FriendsScreen(),
    ProfileScreen()
  ];

    @override
  void initState(){
    Provider.of<UserProvider>(context,listen: false).getCurrentUser();
    super.initState();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainScreens[currentIndex],
      bottomNavigationBar: CircleNavBar(
        activeIndex: currentIndex,
        activeIcons: [
          Icon(CupertinoIcons.chat_bubble, color: Theme.of(context).primaryColor),
          Icon(CupertinoIcons.person_2, color: Theme.of(context).primaryColor),
          Icon(Icons.settings, color: Theme.of(context).primaryColor),
        ],
        inactiveIcons: [
          Text("Chat"),
          Text("Friends"),
          Text("Settings"),
        ],
        color: Theme.of(context).cardColor,
        //shadowColor: Colors.grey.shade200,
        circleColor: Colors.white,
        height: 60,
        circleWidth: 60,
        onTap: (v) {
          //print("${Provider.of<UserProvider>(context).currentUser?.name}");
          setState(() {
            currentIndex = v;
          });
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        circleShadowColor: Colors.grey,
        elevation: 10,
        //shadowColor: Theme.of(context).primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [Colors.blue, Colors.red],
        // ),
        circleGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey,
            Colors.grey.shade100,
            Colors.grey.shade200,
            Colors.grey.shade300,
            Colors.grey.shade400,
            Colors.grey.shade500,
          ],
        ),
      ),
    
    
    );
  }
}
