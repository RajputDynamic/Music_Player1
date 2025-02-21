import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/repository/Authentication_repo/AuthenticationRepository.dart';
import 'package:music_player/view/Screens/HomeScreens/Home_view.dart';
import 'package:music_player/view/Screens/Search%20Screens/DeezerAudio.dart';
import 'package:music_player/view/Screens/Search%20Screens/search_tab.dart';
import 'package:music_player/view/Screens/Songs%20Screen/songs_view.dart';
import 'package:music_player/view/Screens/splashScreens/Gradient_Color_BG.dart';
import 'package:music_player/view/Screens/splashScreens/welcome_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with
    SingleTickerProviderStateMixin {
  TabController?controller;

  int selectTab=0;
  @override
  void initState(){
    super.initState();
    controller=TabController(length: 4, vsync: this );

    controller?.addListener((){
      selectTab=controller?.index??0;
      setState(() {
      });
      });
  }
  Gradient myGradient = LinearGradient(
    colors: [Colors.blue, Colors.purple],
  );
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
 @override
  Widget build(BuildContext context) {
   final _auth=Authentication_Repository();
   double screenWidth = MediaQuery.of(context).size.width;
   double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBody: true,
      body: TabBarView(controller: controller,
          children: [
         HomeView(),
         SearchPage(),
         songsView(),
            Container(
              child: Center(child: Text("Settings"),),
            ),
      ],),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xAA000000),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0, -8),
              blurRadius: 30,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: Color(0x66000000),
              offset: Offset(0, -5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SizedBox(
          child: BottomAppBar(
            color: Colors.transparent,
              elevation: 0,
              child: TabBar(
                controller: controller,
                  indicatorColor: Colors.transparent,
                  labelStyle:  TextStyle(fontSize: screenWidth*0.04),
                  unselectedLabelColor: Colors.white,
                  unselectedLabelStyle:  TextStyle(fontSize: screenWidth*0.03),
                  tabs: [
                    Tab(
                        child: gradientText("Home",
                          TextStyle(fontWeight: FontWeight.normal),
                          myGradient,
                        ),
                      icon: Opacity(
                        opacity: selectTab == 0 ? 1.0 : 0.6,
                        child: Image.asset(
                          selectTab==0? "assets/home_icon.png"
                              :"assets/home_unSel.png" ,
                          width: screenWidth*0.08,
                          color: Colors.white,
                        ),
                      )

                    ),
                    Tab(
                      child: gradientText("Search",
                        TextStyle(fontWeight: FontWeight.normal),
                        myGradient,
                      ),
                      icon: Opacity(
                        opacity: selectTab == 1 ? 1.0 : 0.6,
                        child: Image.asset(
                          selectTab==1? "assets/search-Sel.png"
                              :"assets/Search-unSel.png" ,
                          width: screenWidth*0.08,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                        child: gradientText("Songs",
                          TextStyle(fontWeight: FontWeight.normal),
                          myGradient,
                        ),
                        icon: Opacity(
                          opacity: selectTab == 2 ? 1.0 : 0.6,
                          child: Image.asset(
                            selectTab==2? "assets/Songs_icon.png"
                                :"assets/songs_icon_unSel.png" ,
                            width: screenWidth*0.08,
                            color: Colors.white,
                          ),
                        )

                    ),
                    Tab(
                        child: gradientText("Settings",
                            TextStyle(fontWeight: FontWeight.normal),
                            myGradient,
                        ),
                        icon: Opacity(
                          opacity: selectTab == 3 ? 1.0 : 0.6,
                          child: Image.asset(
                            selectTab==3? "assets/settings_icon.png"
                                :"assets/settings_icon_un.png" ,
                            width: screenWidth*0.08,
                            color: Colors.white,
                          ),
                        ),
                    ),

                  ]
              ),
          ),
        ),
      )
    );
  }
}
