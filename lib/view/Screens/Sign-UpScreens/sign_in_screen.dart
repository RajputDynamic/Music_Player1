import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/view/Screens/Sign-UpScreens/sign_in_header.dart';

import '../../../repository/Authentication_repo/AuthenticationRepository.dart';

import '../HomeScreens/home_Screen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _auth=Authentication_Repository();
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    signInHeaderWidget(size),
            Form(

              child: Column(

                children: [
                  SizedBox(height: screenHeight*0.2,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          // Show Loading
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(child: CircularProgressIndicator()),
                          );
              
                          UserCredential? userCredential = await _auth.signInWithGoogle();
              
                          if (userCredential != null) {
                            print('Signed In: ${userCredential.user?.displayName}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signed in as ${userCredential.user?.displayName}')),
                            );
                            Get.offAll(()=> HomeScreen());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sign In cancelled')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      },

                      label: Text("Sign-In with Google",style: GoogleFonts
                          .poppins(
                        fontSize: screenWidth*0.06,
                        fontWeight: FontWeight.w600,
                      ),),
                      icon: Image(image: AssetImage("assets/google_logo.png"),
                        width: 70.0,
                        alignment: Alignment.topLeft,
                      ),
              
                      style: OutlinedButton.styleFrom(
                          elevation: 10,
                          side: BorderSide(width: 1,color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12,),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
                      ],
                    ),
                ),
    );
  }
}


