import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:message_app/data/models/userModel.dart';
import 'package:message_app/presentation/pages/auth/loginPage.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile".toUpperCase(),
          style: TextStyle(letterSpacing: 5),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //edit profile
                          ListTile(
                            onTap: () {},
                            leading: Icon(IconlyBold.edit),
                            title: Text("Edit Profile"),
                          ),

                          ListTile(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => true);
                            },
                            leading: Icon(IconlyBold.logout),
                            title: Text("Logout"),
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            if (value.currentUser != null) {
              UserModel user = value.currentUser!;
              print("user profile : ${user.name}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///user top profile widget
                  Container(
                    height: user.coverImage == null || user.coverImage == ""
                        ? 100
                        : 235,
                    //color: Colors.green,
                    child: Stack(
                      children: [
                        user.coverImage == null || user.coverImage == ""
                            ? Container()
                            : Container(
                                width: double.infinity,
                                height: 210,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${user.coverImage}",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                        Positioned(
                          bottom: 0,
                          left: 11,
                          child: Container(
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: user.profileImage == null ||
                                    user.profileImage == ""
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "${user.profileImage}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 11, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${user.name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text("${user.bio}", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 15, bottom: 15),
                  //   child: Divider(thickness: 2),
                  // ),

                  Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
