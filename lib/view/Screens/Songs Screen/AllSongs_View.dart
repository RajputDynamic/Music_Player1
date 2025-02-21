// lib/views/all_songs_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/main_player/MainPlayerView.dart';
import '../../../Controllers/All_Songs_Controller.dart';

class AllSongsView extends StatelessWidget {
  final allVM = Get.put(AllSongsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: allVM.allList.length,
      itemBuilder: (context, index) {
        var sObj = allVM.allList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(sObj['image']),
          ),
          title: Text(sObj['name']),
          subtitle: Text(sObj['artists']),
          trailing: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Get.to(() => main_player_view(
                imageUrl: sObj['image'],
                title: sObj['name'],
                artist: sObj['artists'],
              ));
            },
          ),
          onTap: () {
            // open details or go back
          },
        );
      },
    )
    );
  }
}
