import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/view/Screens/Sign-UpScreens/sign_in_screen.dart';
import 'Gradient_Color_BG.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
class  WelcomeScreen extends StatelessWidget {
  const WelcomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  Scaffold(
      body:  Stack(
          children: [
      Positioned.fill(
      child: CustomPaint(
      painter: gradientApply([Colors.pink, Colors.deepPurple]),
    ),
    ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                   Lottie.asset('assets/Welcome_Screen.json',height: size.height*0.4,
                       fit: BoxFit.cover),
                 AutoSizeText(
                     "Welcome to the Musix",
                     style: GoogleFonts.montserrat(fontSize: 40,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                   // Smallest text size allowed
                 ),
                 AutoSizeText(
                   "Vibe the Music with Muisx",
                   style: GoogleFonts.poppins(fontSize: 30,fontWeight:
                   FontWeight.normal),
                   textAlign: TextAlign.start,
                   // Smallest text size allowed
                 ),

                 Center(
                   child: OutlinedButton(
                     onPressed: (){
                      Get.to(()=>SignInScreen());
                     },
                     style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.black,),padding:EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
                       child: Text("Sign Up",style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 22,),),
                   ),
                 ),
               ],
                 )
               ],
             ),

    );
  }

}
