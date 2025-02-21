import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/Constants/GenreCell.dart';
import '../../../View_Model/GenreViewModel.dart';
class Genres extends StatefulWidget {
  const  Genres({super.key});

  @override
  State<Genres>createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  final genVM=Get.put(GenreViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15,
              childAspectRatio: 1.4,
          ),
          itemCount: genVM.allList.length,
          itemBuilder: (context, index){
               var cObj=genVM.allList[index];
            return GenreCell(
              cObj: cObj,
              onPressed: (){
              },
            );
          }
      ),
    );
  }
}
