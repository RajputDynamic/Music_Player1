import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class GenreCell extends StatelessWidget {
  final Map cObj;
  final VoidCallback onPressed;
  const GenreCell({super.key,required this.cObj,required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
            cObj["image"],
             width: double.maxFinite,
            height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black38,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(cObj["name"],style: GoogleFonts.aBeeZee(fontWeight:
            FontWeight.bold,
              color: Colors.black,
              fontSize: 28,),),
            Text(cObj["songs"],style: GoogleFonts.aBeeZee(fontWeight:
            FontWeight.bold,
              color: Colors.black,
              fontSize: 24,),),
          ],
        )
      ],
    );
  }
}
