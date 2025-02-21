import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
Column signInHeaderWidget(Size size) {
  return Column(
    children: [
      SizedBox(height: 50,),
      Lottie.asset("assets/Sign_In_Screen.json", height: size
          .height * 0.4, width: 600,
      ),
      SizedBox(height: 20,),
      Text("SignIn", style: GoogleFonts.aBeeZee(
        fontWeight: FontWeight.bold,
        fontSize: 62,
      ),),
      SizedBox(height: 40,),
       Text("To On-Board with Musix, Sign-In here",
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          softWrap: true,),
    ],
  );

}