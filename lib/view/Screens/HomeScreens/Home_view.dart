import 'package:flutter/material.dart';
import 'package:music_player/Constants/title.dart';
import 'package:music_player/Controllers/control_songs_view.dart';
import 'package:music_player/view/Screens/HomeScreens/DrawerWidget.dart';
import '../splashScreens/Gradient_Color_BG.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Gradient myGradient = LinearGradient(
    colors: [Colors.blue, Colors.purple],
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
            icon: Image.asset(
              "assets/menu-img.png",
              width: 30,
              height: 30,
              fit: BoxFit.contain,),),
        title: Center(
           child: gradientText(
               "Musix",
               TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                myGradient,
        ),),
        backgroundColor: Colors.black38,
      ),
      drawer: Drawerwidget(),
                body: SingleChildScrollView(
                child: Column(
                children: [
                const TitleSection(title: "Hot Recommended"),
                SizedBox(height: 10,),
                fetchSongs(collection: "RecentArr"),
                const TitleSection(title: "Recent Songs"),
                SizedBox(height: 10,),
                fetchSongs(collection: "RecentArr"),
            const TitleSection(title: "Romantic songs"),
            SizedBox(height: 10,),
            fetchSongs(collection: "RecentArr"),
            const TitleSection(title: "90's Albums"),
            SizedBox(height: 10,),
            fetchSongs(collection: "RecentArr"),
                  ],
            ),
      ),
    );
  }
}
