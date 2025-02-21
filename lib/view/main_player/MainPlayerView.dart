import 'package:flutter/material.dart';
import 'package:get/get.dart';
class main_player_view extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String artist;

  main_player_view({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  @override
  State<main_player_view> createState() => _main_player_viewState();
}

class _main_player_viewState extends State<main_player_view> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded,)),
        title: Center(
          child: Text("Now Playing"),
      ),
        actions: [
      PopupMenuButton<int>(
      color: const Color(0xff383B49),
        offset: const Offset(-10, 15),
        elevation: 1,
        icon: Icon(Icons.more_vert_rounded,),
        // onSelected: (selectIndex) {
        //   if (selectIndex == 2) {
        //     openPlayPlaylistQueue();
        //   } else if (selectIndex == 9) {
        //     openDriverModel();
        //   }
        // },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 1,
              height: 40,
              child: Text(
                "Add to Favourites",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const PopupMenuItem(
              value: 3,
              height: 40,
              child: Text(
                "Share",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const PopupMenuItem(
              value: 4,
              height: 40,
              child: Text(
                "Lyrics",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const PopupMenuItem(
              value: 6,
              height: 40,
              child: Text(
                "Details",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ];
        }),
    ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight*0.02,),
            Stack(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth*0.7),
                  child: Image.network(widget.imageUrl, width: screenWidth*0.7, height: screenWidth*0.7, fit: BoxFit.cover),
                )
              ],
            ),
            Row(
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
