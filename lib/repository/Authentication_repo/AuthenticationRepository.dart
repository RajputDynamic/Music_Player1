import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_player/view/Screens/HomeScreens/home_Screen.dart';
import 'package:music_player/view/Screens/splashScreens/welcome_screen.dart';

class Authentication_Repository extends GetxController{

final _auth = FirebaseAuth.instance;

late final Rx<User?> firebaseUser;
var verificationId="".obs;
@override
void onReady(){
  Future.delayed(const Duration(seconds: 6));
  firebaseUser=Rx<User?>(_auth.currentUser);
  firebaseUser.bindStream(_auth.userChanges());
  ever(firebaseUser, _firstScreen);
}
_firstScreen(User? user){
  user==null? Get.offAll(WelcomeScreen()) : Get.offAll(HomeScreen());
}
final GoogleSignIn _googleSignIn = GoogleSignIn();


Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      // User cancelled sign-in
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);

    return userCredential;
  } catch (e) {
    print('Error during Google Sign-In: $e');
    throw e; // rethrow for snackbar
  }
}
Future<UserCredential?> logout() async {
  try {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

}