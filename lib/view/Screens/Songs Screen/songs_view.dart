import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/Screens/Songs%20Screen/Geners_view.dart';
import '../splashScreens/Gradient_Color_BG.dart';
import 'AllSongs_View.dart';
class songsView extends StatefulWidget {
  const songsView({super.key});

  @override
  State<songsView> createState() => _songsViewState();
}

class _songsViewState extends State<songsView> with
    SingleTickerProviderStateMixin {
  TabController? controller;
 int selectTab=0;
 @override
  void initState(){
   super.initState();
   controller=TabController(length: 5, vsync: this);
   controller?.addListener((){
     selectTab=controller?.index??0;
     setState(() {
     });
   });
 }
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
  Gradient myGradient = LinearGradient(
    colors: [Colors.blue, Colors.purple],
  );
  Gradient myGradient2 = LinearGradient(
    colors: [Colors.yellowAccent, Colors.deepOrangeAccent],
  );
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: gradientText(
          "Songs by Musix",
          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          myGradient,
        ),
        backgroundColor: Colors.black38,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(color: Colors.transparent, width: 0), // removes line
              ),
            ),
            child: TabBar(
              labelPadding: EdgeInsets.only(left: 5),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              controller: controller,
                tabs: [
               Tab(
                   child: gradientText("All Songs", TextStyle(
                       fontSize: screenWidth*0.04,
                       fontWeight: FontWeight.bold),
                       myGradient2),
               ),
                  Tab(
                      child: gradientText("Albums", TextStyle(
                          fontSize: screenWidth*0.04,
                          fontWeight:FontWeight.bold),
                          myGradient2),

                  ),
                  Tab(
                      child: gradientText("Artists", TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: screenWidth*0.04,),
                          myGradient2),
                  ),
                  Tab(
                      child: gradientText("Playlists", TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: screenWidth*0.04,),
                          myGradient2),
                  ),
                  Tab(
                      child: gradientText("Geners", TextStyle(
                      fontSize: screenWidth*0.04,
                          fontWeight:FontWeight.bold),
                          myGradient2),
                  ),
            ]),
          ),
          Expanded(child: TabBarView( controller: controller,
              children: [
                AllSongsView(),
                Container(child: Center(child: Text("Albums"),),),
                Container(child: Center(child: Text("Artist"),),),
                Container(child: Center(child: Text("Playlist"),),),
                Genres(),
          ]))
        ],
      ),
    );
  }
}
