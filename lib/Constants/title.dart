import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/Screens/splashScreens/Gradient_Color_BG.dart';
class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Gradient myGradient = LinearGradient(
      colors: [Color(0xFFE1BEE7),Color(0xFF81D4FA),],
    );
    return Padding(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: gradientText(
          title,
          TextStyle(
            fontSize: screenWidth*0.06,
            fontWeight: FontWeight.bold,),
            myGradient,
        ),
      ),
    );
  }
}
