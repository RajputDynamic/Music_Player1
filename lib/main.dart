import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Controllers/firebase_data_config.dart';
import 'package:music_player/repository/Authentication_repo/AuthenticationRepository.dart';
import 'package:music_player/view/Screens/HomeScreens/home_Screen.dart';
import 'package:music_player/view/Screens/Sign-UpScreens/sign_in_screen.dart';
import 'package:music_player/view/Screens/splashScreens/splash_screen.dart';
import 'package:music_player/view/Screens/splashScreens/welcome_screen.dart';

import 'firebase_options.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ConfigFirebaseForSongs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/welcome': (context)=> WelcomeScreen(),
        '/home':(BuildContext context)=> HomeScreen(),
        '/Sign_In': (context)=>SignInScreen(),

      },
      theme: ThemeData.dark().copyWith(
      tabBarTheme: const TabBarTheme(
        dividerColor: Colors.transparent,
      ),
      ),
      // darkTheme: ThemeData.dark(),
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      title: "Music Player",color: Colors.deepOrange,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );

  }

}