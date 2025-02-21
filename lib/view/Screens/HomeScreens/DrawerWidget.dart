import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/AlertDialogBox.dart';
import '../../../repository/Authentication_repo/AuthenticationRepository.dart';
class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: [
          Builder(
            builder: (context) {
              final user = FirebaseAuth.instance.currentUser;

              return DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.blue],
                  ),
                ),
                child: user == null ?
                     Text("Not signed in")   //Never going to shown up
                    : Row(
                  children: [
                    CircleAvatar(
                      radius: screenWidth*0.1,
                      backgroundImage: NetworkImage(
                        user.photoURL ?? 'https://via.placeholder.com/150',
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName ?? ' ',
                          style: TextStyle(color: Colors.white,
                              fontSize: screenWidth*0.06),
                        ),
                        Text(
                          user.email ?? '',
                          style: TextStyle(color: Colors.white70,
                              fontSize:screenWidth*0.03),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home',style: TextStyle(fontSize: screenWidth*0.05),),
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.library_music),
                  title: Text('Songs',style: TextStyle(fontSize: screenWidth*0.05),),
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.settings),
                  title:  Text('Settings',style: TextStyle(fontSize: screenWidth*0.05),),
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: 20,),
                ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout',style: TextStyle(fontSize:
                    screenWidth*0.05),),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogBox(screenWidth: screenWidth);
                        },
                      );
                    }
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Divider(),
                Text(
                  '🎧 Made by 💖 in Flutter',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  'v1.0.0',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}