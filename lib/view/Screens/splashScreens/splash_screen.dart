import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/Constants/sizes.dart';
import 'package:music_player/Constants/text_strings.dart';
import 'package:music_player/view/Screens/Sign-UpScreens/sign_in_screen.dart';


import '../HomeScreens/home_Screen.dart';
import 'Gradient_Color_BG.dart';
 class SplashScreen extends StatelessWidget {
   const SplashScreen({super.key});

   @override
   Widget build(BuildContext context) {
     final size=MediaQuery.of(context).size;
     WidgetsBinding.instance.addPostFrameCallback((_) {
       final user = FirebaseAuth.instance.currentUser;
       Future.delayed(Duration(seconds: 3), () {
         if (user != null) {
           // Already signed in
           Get.offAll(() => HomeScreen());
         } else {
           // Not signed in
           Get.offAll(() => SignInScreen());
         }
       });
     });
     return Scaffold(
       body: Stack(
         children: [
           Positioned.fill(
             child: CustomPaint(
               painter: gradientApply([Colors.pink, Colors.deepPurple]),
             ),
           ),

// -----------------Here Comes the Title for the  App Name ----------------

           Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Text(AppName, style: GoogleFonts.montserrat(
                 fontWeight: FontWeight.bold,
                 fontSize: 95,
                 color: Colors.white70,
               ),
               ),
//---------------- Here comes the Animation beholding the json Lottie file----------------------
               Lottie.asset('assets/Animation - 1742746973149-LHbai.json',
                 height: size.height*0.5,
                 frameRate: FrameRate.max, fit: BoxFit.fill,),
               Text(TagLine, style: GoogleFonts.lobster(
                 fontWeight: FontWeight.w300,
                 fontSize: 50,
                 color: Colors.white70,
               ),
               textAlign: TextAlign.center,),

             ],
           ),

           //  Center(
           //   child: Container(
           //     child: Lottie.asset('assets/Animation - 1742746973149.json'),
           //   )
           // ),
         ],
       ),
     );
   }
 }
   //------------- this where the Routing of the Welcome Screen Comes with Tranisition step using "PageRouteBUilder"
